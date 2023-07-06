import 'package:camera/camera.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/dataCollectionScreen/collection_captured_screen.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:fluttertest/widgets/custom_path.dart';
import 'package:fluttertest/widgets/myBottomNavBar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../generated/l10n.dart';
import 'cameraCubit/camera_cubit.dart';
import 'capturedCubit/captured_cubit.dart';

class CollectionCameraScreen extends StatelessWidget {
  const CollectionCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraCubit>(
      create: (_) => CameraCubit(),
      child: Scaffold(
        body: BlocBuilder<CameraCubit, CameraState>(
          builder: (context, state) {
            if (state is CameraInitial) {
              context.read<CameraCubit>().initializeCamera();
              return const Center(child: CircularProgressIndicator());
            } else if (state is CameraInitialized) {
              return const CameraView();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class CameraView extends StatefulWidget {
  final double initialZoomLevel;

  const CameraView({
    Key? key,
    this.initialZoomLevel = 1.0,
  }) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  double _zoomLevel = 1.0;
  double _baseZoomLevel = 1.0;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.initialZoomLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      bottomNavigationBar: myBottomNavBar(context, 1),
      appBar: AppBar(
        title: Text(S.of(context).capture),
      ),
      body: BlocBuilder<CameraCubit, CameraState>(
        builder: (context, state) {
          if (state is CameraInitialized) {
            return FutureBuilder<void>(
              future: context.read<CameraCubit>().initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onScaleStart: _onScaleStart,
                    onScaleUpdate: _onScaleUpdate,
                    onScaleEnd: _onScaleEnd,
                    onDoubleTap: _onDoubleTap,
                    child: Stack(
                      children: [

                        Center(
                          child: CameraPreview(
                              context.read<CameraCubit>().controller),
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: ToggleSwitch(
                                initialLabelIndex: context.read<CameraCubit>().currentIndex,
                                animate: true,
                                totalSwitches: 2,
                                activeBorders: [
                                  Border.all(
                                    color: Colors.purple,
                                    width: 3.0,
                                  ),
                                  Border.all(
                                    color: Colors.yellow.shade700,
                                    width: 3.0,
                                  ),
                                  Border.all(
                                    color: Colors.deepOrangeAccent,
                                    width: 3.0,
                                  ),
                                  Border.all(
                                    color: Colors.blue.shade500,
                                    width: 3.0,
                                  ),
                                ],
                                labels: ['Normal', 'Collect'],
                                onToggle: (index) {
                                  context.read<CameraCubit>().toggleMode(index!);
                                  setState(() {});
                                },
                              ),
                            ),
                            context.read<CameraCubit>().dataCollectionModeIsOn?Container():Guideline_Widget(width: MediaQuery.of(context).size.width.w),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${_zoomLevel.toStringAsFixed(2)}x',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Slider.adaptive(
                                      value: _calculateSliderValue(_zoomLevel),
                                      min: 0.0,
                                      max: 30.0,
                                      inactiveColor: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .color!,
                                      activeColor: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .color!,
                                      onChanged: _onSliderChanged,
                                    ),
                                    OutlinedButton(onPressed: () async {
                                      String? imagePath = await context
                                          .read<CameraCubit>()
                                          .takePicture();
                                      context.read<CameraCubit>().dataCollectionModeIsOn?Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CollectionCapturedScreen(
                                                capturedCubit: CapturedCubit(),
                                                imagePath: imagePath,
                                              ),
                                        ),
                                      ):Navigator.popAndPushNamed(
                                        context,
                                        "/upload",
                                        arguments: {'imagePath': imagePath},
                                      );


                                    }, style: ButtonStyle(
                                        backgroundColor: Theme.of(context)
                                            .outlinedButtonTheme
                                            .style
                                            ?.shadowColor),child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera),
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        Text(S.of(context).capture)
                                      ],
                                    ))
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),

    );
  }

  double _calculateSliderValue(double zoomLevel) {
    return (zoomLevel - 1.0) / 4.0 * 40.0;
  }

  double _calculateZoomLevel(double sliderValue) {
    return 1.0 + sliderValue / 40.0 * 4.0;
  }

  void _onSliderChanged(double value) async {
    _zoomLevel = _calculateZoomLevel(value);
    await context.read<CameraCubit>().setZoomLevel(_zoomLevel);
    setState(() {});
  }

  void _onScaleStart(ScaleStartDetails details) {
    _baseZoomLevel = _zoomLevel;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) async {
    double newZoomLevel = _baseZoomLevel * details.scale;
    final maxZoomLevel =
        await context.read<CameraCubit>().controller.getMaxZoomLevel();
    final minZoomLevel =
        await context.read<CameraCubit>().controller.getMinZoomLevel();
    newZoomLevel = newZoomLevel.clamp(minZoomLevel, maxZoomLevel);

    if (_zoomLevel != newZoomLevel) {
      _zoomLevel = newZoomLevel;
      await context.read<CameraCubit>().setZoomLevel(_zoomLevel);
      setState(() {});
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _baseZoomLevel = _zoomLevel;
  }

  void _onDoubleTap() {
    setState(() {
      _zoomLevel = 1.0;
      _dragOffset = Offset.zero;
    });
  }

  double _getAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final cameraRatio =
        context.read<CameraCubit>().controller.value.aspectRatio;
    return cameraRatio / deviceRatio;
  }
}
