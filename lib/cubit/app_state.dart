part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {
}

class ChangedTabIndex extends AppState{}
class CameraStarted extends AppState{}
class ZoomLevelChanged extends AppState{}
class WaitingResult extends AppState{}
class TestDone extends AppState{}