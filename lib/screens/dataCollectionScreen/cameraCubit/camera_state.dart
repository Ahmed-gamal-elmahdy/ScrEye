part of 'camera_cubit.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraCapturing extends CameraState {}

class CameraInitialized extends CameraState {}
