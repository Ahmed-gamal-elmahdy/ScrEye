part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {
}

class ChangedBodyIndex extends AppState{}
class CameraStarted extends AppState{}
class ZoomLevelChanged extends AppState{}
class WaitingResult extends AppState{}
class TestDone extends AppState{}
class TestError extends AppState{}
class Loading extends AppState{}
class NotLoading extends AppState{}
class Uploading extends AppState{}
class DoneUploading extends AppState{}

class ChangedTabIndex extends AppState{}
class ChangedLanguage extends AppState{}