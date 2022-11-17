import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

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
  String test_result = "";
  double sliderVal = 1.0;

  void ChangeTabIndex(idx) {
    tabIndex = idx;
    emit(ChangedTabIndex());
  }

  void updateZoomLevel(val) async {
    await controller.setZoomLevel(val);
    sliderVal = val;
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

  void setUser(User) {
    user = User;
  }
  void testGet({required String imgname, required String token}) async {
    tabIndex=2;
    emit(WaitingResult());
    test_result = await getApi(imgname: imgname, token: token);
    emit(TestDone());
  }

  Future<String> getApi({required String imgname, required String token}) async {
    var url =
        "https://flaskapitestgemy.herokuapp.com/api/v1/?id=${imgname}&token=${token}";
    print(url);
    var dio = Dio();
    var resp = await dio.get(url);
    print(resp.data);
    return resp.data;
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: Stack(
          children: [
            capturedImage != null ? Image.memory(capturedImage) : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Discard'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ImageGallerySaver.saveImage(capturedImage);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text("Save"),
                  ),
                  ElevatedButton.icon(
                    label: Text('Upload'),
                    icon: Icon(Icons.upload),
                    onPressed: () async {
                      uploadImage(capturedImage).then((data) async {
                        testGet(imgname: data[0], token: data[1]);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<List> uploadImage(image) async {
    final tempDir = await getTemporaryDirectory();
    var now = DateTime.now();
    var name =
        '${DateFormat('dd-MM-yy').format(now)}-${DateFormat('kk-mm').format(now)}';
    File file = await File('${tempDir.path}/image.jpg').create();
    if (image.runtimeType ==XFile){
      file=File(image.path);
    }
    else{
      file.writeAsBytesSync(image);
    }
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _firebaseStorage.ref().child('images/${name}').putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      const startWord = "token=";
      final startIndex =   downloadUrl.indexOf(startWord);
      final endIndex =   downloadUrl.length;
      final String token =  downloadUrl
          .substring(startIndex + startWord.length, endIndex);
      print('token = ${token}');
      print('name = ${name}');
      return[name,token];
    }
    return ["name", "token"];
  }
}


