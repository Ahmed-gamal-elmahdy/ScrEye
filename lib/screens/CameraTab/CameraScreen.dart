import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';

import 'package:fluttertest/widgets/custom_path.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

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
        var isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        final size = MediaQuery.of(context).size;
        final deviceRatio = size.width / size.height;
        if (!cubit.controller.value.isInitialized) {
          return Container(child: Text("please wait"),);
        }
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 517.h,
                  child: new OverflowBox(
                    alignment: Alignment.center,
                    child: CameraPreview(cubit.controller),
                  ),
                ),
                Guideline_Widget(width: size.width.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 465.h,
                      width: 51.w,
                      decoration: BoxDecoration(
                        //color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                               cubit.zoomIn();
                              },
                              icon: Icon(Icons.zoom_in),
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.zoomOut();
                              },
                              icon: Icon(Icons.zoom_out))
                        ],
                      ),
                    ),
                    Container(
                      height: 51.9.h,
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.zoom_in_outlined,color: Colors.blue),
                          cubit.cameraInitiated?Slider.adaptive(
                              min:cubit.minZoom,
                              max: cubit.maxZoom,
                              value: cubit.sliderVal,onChanged: (value){
                                    cubit.updateZoomLevel(value);
                          }):Container(),
                          SizedBox(
                            width: 120.h,
                            child: ElevatedButton(
                                onPressed: () async {
                                  XFile picture = await cubit.controller.takePicture();
                                  screenshotController
                                      .captureFromWidget(Center(
                                    child: ClipPath(
                                      clipper: MyClipper(),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: size.width.w,
                                            height: 515.h,
                                            child: Image.file(File(picture.path)),
                                          ),
                                          //Guideline_Widget(width: size.width)
                                        ],
                                      ),
                                    ),
                                  ))
                                      .then((value) async {
                                    
                                    var result=await ImageGallerySaver.saveImage(value);
                                    print(result);
                                    cubit.uploadImg(result["filePath"]);
                                    //ShowCapturedWidget(context, value);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Text("Capture")
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Future<dynamic> ShowCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text("Captured widget screenshot"),
      ),
      body: Center(
          child: Stack(
        children: [
          capturedImage != null ? Image.memory(capturedImage) : Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 120.h,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text("Discard")
                        ],
                      )),
                ),
                SizedBox(
                  width: 50.w,
                ),
                SizedBox(
                  width: 120.h,
                  child: ElevatedButton(
                      onPressed: () async {
                       await ImageGallerySaver.saveImage(capturedImage);
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_alt),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text("Save")
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    ),
  );
}
