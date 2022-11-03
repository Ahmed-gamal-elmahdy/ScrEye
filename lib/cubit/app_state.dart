part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {
}

class ViewResult extends AppState{}
class ViewHome extends AppState{}
class ViewCamera extends AppState{}
class ChangedTabIndex extends AppState{}
class CameraStarted extends AppState{}
class ZoomOut extends AppState{}
class ZoomIn extends AppState{}
class ZoomLevelChanged extends AppState{}