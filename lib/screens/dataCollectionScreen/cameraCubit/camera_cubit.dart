import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());
  bool _dataCollectionModeIsOn = false;
  int _currentIndex=0;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    const focusPoint = Offset(0.5, 0.5);

    _initializeControllerFuture = _controller.initialize();
    _controller.setFlashMode(FlashMode.off);
    emit(CameraInitialized());
  }

  Future<void> setZoomLevel(double zoomLevel) async {
    if (!_controller.value.isInitialized) {
      return;
    }
    await _controller.setZoomLevel(zoomLevel);
  }

  Future<String?> takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    try {
      XFile picture = await _controller.takePicture();

      String? finalPath = await copyImage(picture.path);
      return finalPath;
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }

  Future<String?> copyImage(String imagePath) async {
    // Get the app's documents directory
    Directory documentsDir = await getApplicationDocumentsDirectory();

    // Create a new file in the documents directory with a unique name
    File newFile = File(
        '${documentsDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Copy the captured image file to the new file
    try {
      await File(imagePath).copy(newFile.path);
      return newFile.path;
    } catch (e) {
      debugPrint('Error copying image: $e');
      return null;
    }
  }

  Future<void> get initializeControllerFuture => _initializeControllerFuture;
  int get    currentIndex=>_currentIndex;
  CameraController get controller => _controller;
  bool get dataCollectionModeIsOn => _dataCollectionModeIsOn;

  void toggleMode(int index){
    if(index==_currentIndex){
      return;
    }
    if(index==0){
      _dataCollectionModeIsOn = false;

    }
    else{
      _dataCollectionModeIsOn = true;
    }
    _currentIndex=index;
  }
  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
