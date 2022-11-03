import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int tabIndex = 0;
  bool cameraInitiated = false;
  late List<CameraDescription> cameras;
  late double maxZoom, minZoom, zoomLevel;
  late CameraController controller;
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
}
