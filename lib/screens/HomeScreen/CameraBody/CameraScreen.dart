import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/widgets/custom_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:screenshot/screenshot.dart';

import '../../../generated/l10n.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        final size = MediaQuery.of(context).size;
        final deviceRatio = size.width / size.height;
        if (!cubit.controller.value.isInitialized) {
          return Container(
            child: Text(S.of(context).pls_wait),
          );
        } else {
          return Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 517.h,
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: CameraPreview(cubit.controller),
                    ),
                  ),
                  Guideline_Widget(width: size.width.w),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 51.9.h,
                      color: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .color!
                          .withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.zoom_in_outlined,
                              color: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .color!),
                          cubit.cameraInitiated
                              ? Slider.adaptive(
                                  min: cubit.minZoom,
                                  max: cubit.maxZoom,
                                  inactiveColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                  activeColor: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .color!,
                                  value: cubit.sliderVal,
                                  onChanged: (value) {
                                    cubit.updateZoomLevel(value);
                                  })
                              : Container(),
                          SizedBox(
                            width: 120.h,
                            child: state is! Loading
                                ? OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor: Theme.of(context)
                                            .outlinedButtonTheme
                                            .style
                                            ?.shadowColor),
                                    onPressed: () async {
                                      cubit.loading();
                                      XFile picture =
                                          await cubit.controller.takePicture();
                                      screenshotController
                                          .captureFromWidget(Center(
                                        child: ClipPath(
                                          clipper: MyClipper(),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: size.width.w,
                                                height: 515.h,
                                                child: Image.file(
                                                    File(picture.path)),
                                              ),
                                              //Guideline_Widget(width: size.width)
                                            ],
                                          ),
                                        ),
                                      ))
                                          .then((value) async {
                                        cubit.ShowCropWidget(context, value);
                                        //cubit.ShowCapturedWidget(context, value);
                                      });
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
                                    ))
                                : OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor: Theme.of(context)
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
                                                    .subtitle2!
                                                    .color!,
                                                size: 10),
                                        SizedBox(
                                          width: 10.h,
                                        ),
                                        Text(S.of(context).capturing)
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
