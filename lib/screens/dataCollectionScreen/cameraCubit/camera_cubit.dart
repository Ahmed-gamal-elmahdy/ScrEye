import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertest/widgets/mySnackBar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../widgets/CustomCropper.dart';
import '../capturedCubit/captured_cubit.dart';
import '../collection_captured_screen.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());
  bool _dataCollectionModeIsOn = false;
  int _currentIndex = 0;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool captureInProgress = false;
  bool _isFrontCameraChosen = false;
  late List<CameraDescription> _cameras = [];
  Future<void> initializeFrontCamera() async {
    if(_cameras.isEmpty){
      _cameras = await availableCameras();
    }
    final camera = _cameras.last;
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    emit(CameraInitialized());
  }

  Future<void> initializeBackCamera() async {
    if(_cameras.isEmpty){
      _cameras = await availableCameras();
    }
    final camera = _cameras.first;
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    try{
      _controller.setFlashMode(FlashMode.off);
    } catch (e){
      debugPrint(e.toString());
    }

    emit(CameraInitialized());
  }




  Future<void> setZoomLevel(double zoomLevel) async {
    if (!_controller.value.isInitialized) {
      return;
    }
    await _controller.setZoomLevel(zoomLevel);
  }

  Future<String?> takePicture(context) async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    try {
      XFile picture = await _controller.takePicture();

      String? finalPath = await copyImage(picture.path);
      return finalPath;
    } catch (e) {
      showSnackBar(context, 'Error taking picture: $e', SnackBarType.error);
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

  int get currentIndex => _currentIndex;

  CameraController get controller => _controller;

  bool get dataCollectionModeIsOn => _dataCollectionModeIsOn;

  void toggleMode(int index) {
    if (index == _currentIndex) {
      return;
    }
    if (index == 0) {
      _dataCollectionModeIsOn = false;
    } else {
      _dataCollectionModeIsOn = true;
    }
    _currentIndex = index;
  }

  void switchCamera(){
    _isFrontCameraChosen =!_isFrontCameraChosen;
    _isFrontCameraChosen? initializeFrontCamera():initializeBackCamera();
  }


  Future<void> router(context, String? imagePath) async {
    if (imagePath == null) {
      return;
    }
    if (_dataCollectionModeIsOn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CollectionCapturedScreen(
            capturedCubit: CapturedCubit(),
            imagePath: imagePath,
          ),
        ),
      );
    } else {
      final cropResult = await showCustomCropper(context, imagePath);
      if(cropResult == null){
        return;
      }
      final cropPath = await _saveImage(cropResult.uiImage);
      Navigator.popAndPushNamed(
        context,
        "/upload",
        arguments: {'imagePath': cropPath},
      );
    }
  }

  Future<String> _saveImage(ui.Image image) async {
    final Uint8List bytes = await _exportImage(image);
    final String dirPath = (await getTemporaryDirectory()).path;
    final String filePath =
        '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  Future<Uint8List> _exportImage(ui.Image image) async {
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to export image');
    }
    final Uint8List bytes = byteData.buffer.asUint8List();
    final Uint8List compressedBytes =
        await FlutterImageCompress.compressWithList(
      bytes,
      format: CompressFormat.jpeg,
      quality: 80,
    );
    return compressedBytes;
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
