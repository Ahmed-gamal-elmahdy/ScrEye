import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/dataCollectionScreen/collection_captured_screen.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  void dispose() {
    context.read<CameraCubit>().close();
    debugPrint("Dispossssssed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
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
                                Slider(
                                  value: _calculateSliderValue(_zoomLevel),
                                  inactiveColor: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .color!,
                                  activeColor: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .color!,
                                  min: 0.0,
                                  max: 30.0,
                                  onChanged: _onSliderChanged,
                                ),
                                    SizedBox(
                                        width: 120.h,
                                        child: OutlinedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .outlinedButtonTheme
                                                        .style
                                                        ?.shadowColor),
                                            onPressed: () async {
                                              String? imagePath = await context
                                                  .read<CameraCubit>()
                                                  .takePicture();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CollectionCapturedScreen(
                                                    capturedCubit:
                                                        CapturedCubit(),
                                                    imagePath: imagePath,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.camera),
                                                SizedBox(
                                                  width: 10.h,
                                                ),
                                                Text(S.of(context).capture)
                                              ],
                                            )),
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
