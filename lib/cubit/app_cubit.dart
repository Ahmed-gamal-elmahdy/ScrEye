import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:loading_animation_widget/loading_animation_widget.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  dynamic user;
  int tabIndex = 0;
  bool cameraInitiated = false;
  late List<CameraDescription> cameras;
  late double maxZoom, minZoom, zoomLevel;
  late CameraController controller;
  final _firebaseStorage = FirebaseStorage.instance;
  String test_result = "";
  double sliderVal = 1.0;

  void ChangeTabIndex(idx) {
    tabIndex = idx;
    emit(ChangedTabIndex());
  }

  void updateZoomLevel(val) async {
    await controller.setZoomLevel(val);
    sliderVal = val;
    emit(ZoomLevelChanged());
  }

  void startCamera() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
    controller.initialize().then((_) {
      cameraInitiated = true;
      _setZooms();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  void _setZooms() async {
    minZoom = await controller.getMinZoomLevel();
    zoomLevel = minZoom;
    maxZoom = await controller.getMaxZoomLevel();
  }

  void setUser(User) {
    user = User;
  }

  void testGet({required String imgname, required String token}) async {
    tabIndex = 2;
    emit(WaitingResult());
    test_result = await getApi(imgname: imgname, token: token);
    emit(TestDone());
  }

  Future<String> getApi(
      {required String imgname, required String token}) async {
    var url =
        "https://flaskapitestgemy.herokuapp.com/api/v1/?id=${imgname}&token=${token}";
    print(url);
    var dio = Dio();
    var resp = await dio.get(url);
    print(resp.data);
    return resp.data;
  }

  //Currently not in use
  // Future<dynamic> ShowCapturedWidget(
  //     BuildContext context, Uint8List capturedImage) {
  //   return showDialog(
  //     useSafeArea: false,
  //     context: context,
  //     builder: (context) => Scaffold(
  //       appBar: AppBar(
  //         title: Text("Your Image"),
  //       ),
  //       body: Center(
  //           child: Stack(
  //         children: [
  //           capturedImage != null ? Image.memory(capturedImage) : Container(),
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 OutlinedButton.icon(
  //                   onPressed: () async {
  //                     Navigator.pop(context);
  //                   },
  //                   icon: Icon(Icons.delete),
  //                   label: Text('Discard'),
  //                 ),
  //                 OutlinedButton.icon(
  //                   onPressed: () async {
  //                     await ImageGallerySaver.saveImage(capturedImage);
  //                     Navigator.pop(context);
  //                   },
  //                   icon: Icon(Icons.save_alt),
  //                   label: Text("Save"),
  //                 ),
  //                 OutlinedButton.icon(
  //                   label: Text('Upload'),
  //                   icon: Icon(Icons.upload),
  //                   onPressed: () async {
  //                     uploadImage(capturedImage).then((data) async {
  //                       testGet(imgname: data[0], token: data[1]);
  //                       Navigator.pop(context);
  //                     });
  //                   },
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       )),
  //     ),
  //   );
  // }

  Future<dynamic> ShowCropWidget(
      BuildContext context, Uint8List capturedImage) {
    final _controller = CropController();
    Uint8List outputimg = capturedImage;
    notLoading();
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Your Image"),
        ),
        body: Stack(
          children: [
            Crop(
                fixArea: true,
                baseColor: Color(0xFF90CBF0),
                initialAreaBuilder: (rect) => Rect.fromLTRB(rect.left + 110.w,
                    rect.top + 160.h, rect.right - 110.w, rect.bottom - 370.h),
                controller: _controller,
                image: capturedImage,
                onCropped: (crop) {
                  outputimg = crop;
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color(0xFFCE772F),
                        content: Text('Image Discarded'),
                      ));
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Discard'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      _controller.crop();
                      Future.delayed(Duration(milliseconds: 1500), () async {
                        await ImageGallerySaver.saveImage(outputimg);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color(0xFF29C469),
                          content: Text('Image saved for later use'),
                        ));
                      });
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text("Save"),
                  ),
                  state is !Uploading? OutlinedButton.icon(
                    label: Text('Upload'),
                    icon: Icon(Icons.upload),
                    onPressed: () async {
                      _controller.crop();
                      Future.delayed(Duration(milliseconds: 1500), () {
                        uploadImage(outputimg).then((data) async {
                          testGet(imgname: data[0], token: data[1]);
                          Navigator.pop(context);
                        });
                      });
                    },
                  ): OutlinedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(color: Color(0xFFF05454), size: 20),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text("Uploading...")
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List> uploadImage(image) async {
    notLoading();
    uploading();
    final tempDir = await getTemporaryDirectory();
    var now = DateTime.now();
    var name =
        '${DateFormat('dd-MM-yy').format(now)}-${DateFormat('kk-mm').format(now)}';
    File file = await File('${tempDir.path}/image.jpg').create();
    if (image.runtimeType == XFile) {
      file = File(image.path);
    } else {
      file.writeAsBytesSync(image);
    }
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _firebaseStorage.ref().child('images/${name}').putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      const startWord = "token=";
      final startIndex = downloadUrl.indexOf(startWord);
      final endIndex = downloadUrl.length;
      final String token =
          downloadUrl.substring(startIndex + startWord.length, endIndex);
      print('token = ${token}');
      print('name = ${name}');
      doneUploading();
      return [name, token];
    }
    doneUploading();
    return ["name", "token"];
  }

  void loading() async {
    emit(Loading());
  }
  void notLoading() async {
    emit(NotLoading());
  }

  void uploading() async {
    emit(Uploading());
  }
  void doneUploading() async {
    emit(DoneUploading());
  }

}