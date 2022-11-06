import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  dynamic user;
  int tabIndex = 0;
  bool cameraInitiated = false;
  late List<CameraDescription> cameras;
  late double maxZoom, minZoom, zoomLevel;
  late CameraController controller;
  final _firebaseStorage = FirebaseStorage.instance;
  String test_result="";
double sliderVal=1.0;
  void resultTab() {
    tabIndex = 2;
    emit(ViewResult());
  }

  void cameraTab() {
    tabIndex = 1;
    emit(ViewCamera());
  }

  void homeTab() {
    tabIndex = 0;
    emit(ViewHome());
  }

  void ChangeTabIndex(idx) {
    tabIndex = idx;
    emit(ChangedTabIndex());
  }

  void zoomIn() {
    if (zoomLevel + 1.0 <= maxZoom) {
      zoomLevel += 1.0;
      updateZoomLevel(zoomLevel);
    }
  }

  void zoomOut() {
    if (zoomLevel - 1.0 >= minZoom) {
      zoomLevel -= 1.0;
      updateZoomLevel(zoomLevel);
    }
  }

  void updateZoomLevel(val) async {
    await controller.setZoomLevel(val);
    sliderVal=val;
    emit(ZoomLevelChanged());
  }

  void startCamera() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
    controller.initialize().then((_) {
      cameraInitiated = true;
      _setZooms();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });

  }

  void _setZooms() async {
    minZoom = await controller.getMinZoomLevel();
    zoomLevel = minZoom;
    maxZoom = await controller.getMaxZoomLevel();
  }
  void setUser(User){
    user = User;
  }
  Future<String> pickImage(image) async {
    if (image != null) {
      //Upload to Firebase
      var file = File(image.path);
      var snapshot = await _firebaseStorage.ref()
          .child('images/imageName')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return "false";
  }
  void testGet() async{
    test_result=await test();
    emit(TestDone());
  }
  Future<String> test() async {
    var url = "https://flaskapitestgemy.herokuapp.com/api/v1/?id=anemia.jpg&token=282c86bf-89b3-4608-b362-753024d73ef4";
    var dio = Dio();
    var resp = await dio.get(url);
    print(resp.data);
    return resp.data;
  }
}

