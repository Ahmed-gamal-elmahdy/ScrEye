import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:fluttertest/widgets/myBottomNavBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../generated/l10n.dart';
import 'cameraCubit/camera_cubit.dart';

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
              context.read<CameraCubit>().initializeBackCamera();
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
  bool captureInProgress = false;

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  context.read<CameraCubit>().switchCamera();
                },
                icon: const Icon(Icons.cameraswitch_rounded)),
          )
        ],
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
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: ToggleSwitch(
                                  cornerRadius: 20.0,
                                  minWidth: 200.w,
                                  initialLabelIndex:
                                      context.read<CameraCubit>().currentIndex,
                                  animate: true,
                                  totalSwitches: 2,
                                  inactiveBgColor: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .color!,
                                  inactiveFgColor: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color!,
                                  activeBgColors: [
                                    [
                                      Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .color!
                                    ],
                                    [
                                      Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .color!
                                    ]
                                  ],
                                  icons: const [
                                    Icons.search,
                                    Icons.text_snippet_rounded,
                                  ],
                                  activeBorders: [
                                    Border.all(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .color!,
                                      width: 1.0,
                                    ),
                                    Border.all(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .color!,
                                      width: 1.0,
                                    ),
                                  ],
                                  labels: [
                                    S.of(context).test_mode_lbl,
                                    S.of(context).collection_mode_lbl
                                  ],
                                  onToggle: (index) {
                                    context
                                        .read<CameraCubit>()
                                        .toggleMode(index!);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                    captureInProgress
                                        ? OutlinedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .outlinedButtonTheme
                                                        .style
                                                        ?.shadowColor),
                                            onPressed: null,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                LoadingAnimationWidget
                                                    .threeArchedCircle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .color!,
                                                        size: 10),
                                                SizedBox(
                                                  width: 10.h,
                                                ),
                                                Text(S.of(context).capturing)
                                              ],
                                            ),
                                          )
                                        : OutlinedButton(
                                            onPressed: () async {
                                              setState(() {
                                                captureInProgress = true;
                                              });
                                              String? imagePath = await context
                                                  .read<CameraCubit>()
                                                  .takePicture(context);
                                              setState(() {
                                                captureInProgress = false;
                                                context
                                                    .read<CameraCubit>()
                                                    .router(context, imagePath);
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .outlinedButtonTheme
                                                        .style
                                                        ?.shadowColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.camera),
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
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.threeArchedCircle(
                          color: Theme.of(context).textTheme.headline5!.color!,
                          size: 50),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        S.of(context).pls_wait,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.subtitle1!.color!,
                        ),
                      ),
                    ],
                  ));
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
