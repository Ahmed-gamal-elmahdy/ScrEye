import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertest/widgets/custom_path.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';

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
                                    ShowCapturedWidget(context, value);


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
                ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Discard'),
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      await ImageGallerySaver.saveImage(capturedImage);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text("Save"),
                ),
                ElevatedButton.icon(label: Text('Upload'), icon:Icon(Icons.upload), onPressed: () async {
                  uploadImage(capturedImage).then((data){
                    const startWord = "token=";
                    final startIndex = data[0].indexOf(startWord);
                    final endIndex = data[0].length;
                    final String token = data[0].substring(startIndex + startWord.length, endIndex);
                    final name = data[1];
                    print('token = ${token}');
                    print('name = ${name}');
                    Navigator.pop(context);
                  });
                },),
              ],
            ),
          )
        ],
      )),
    ),
  );
}

Future<List> uploadImage(image) async {
  final _firebaseStorage = FirebaseStorage.instance;
  final tempDir = await getTemporaryDirectory();
  var now = DateTime.now();
  var name = '${DateFormat('dd-MM-yy').format(now)}-${DateFormat('kk-mm').format(now)}';
  File file = await File('${tempDir.path}/image.jpg').create();
  file.writeAsBytesSync(image);
  if (image != null){
    //Upload to Firebase
    file = File(file.path);
    var snapshot = await _firebaseStorage.ref()
        .child('images/${name}')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return [downloadUrl, name];
  }
  return ["no url","no name"];

}