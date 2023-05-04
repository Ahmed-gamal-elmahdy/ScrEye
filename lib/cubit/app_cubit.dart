import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../generated/l10n.dart';
import '../widgets/Language.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    if (S.current.lang == "English") {
      selectedLanguage = languages[0];
      layoutDirection = TextDirection.ltr;
    } else {
      selectedLanguage = languages[1];
      layoutDirection = TextDirection.rtl;
    }
  }

  static AppCubit get(context) => BlocProvider.of(context);
  dynamic user;
  int bodyIndex = 0;
  bool cameraInitiated = false;
  late List<CameraDescription> cameras;
  late double maxZoom, minZoom, zoomLevel;
  late CameraController controller;
  final _firebaseStorage = FirebaseStorage.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('users');
  final String apiHeroku = "https://screye.herokuapp.com/api/v3/";
  final String apiAzure =
      "https://screyeapi.azurewebsites.net/api/screyeapiv1/";
  List<Language> languages = [
    const Language(name: "English", code: "US"),
    const Language(name: "العربية", code: "EG"),
  ];
  Language? selectedLanguage;
  TextDirection? layoutDirection;
  String test_result = "";
  double sliderVal = 1.0;

  void ChangeBodyIndex(idx) {
    bodyIndex = idx;
    emit(ChangedBodyIndex());
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
      controller.setFlashMode(FlashMode.off);
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint('User denied camera access.');
            break;
          default:
            debugPrint('Handle other errors.');
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
          title: Text(S.of(context).your_img),
        ),
        body: Stack(
          children: [
            Crop(
                fixArea: true,
                baseColor: const Color(0xFF90CBF0),
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
                        backgroundColor: const Color(0xFFCE772F),
                        content: Text(S.of(context).img_discarded),
                      ));
                    },
                    icon: const Icon(Icons.delete),
                    label: Text(S.of(context).discard),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      _controller.crop();
                      Future.delayed(Duration(milliseconds: 1500), () async {
                        await ImageGallerySaver.saveImage(outputimg);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color(0xFF29C469),
                          content: Text(S.of(context).img_saved_later),
                        ));
                      });
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text(S.of(context).save),
                  ),
                  state is! Uploading
                      ? OutlinedButton.icon(
                          label: Text(S.of(context).upload),
                          icon: Icon(Icons.upload),
                          onPressed: () async {
                            _controller.crop();
                            Future.delayed(Duration(milliseconds: 1000), () {
                              uploadImage(image: outputimg).then((data) async {
                                getTest(
                                    imgname: data[0],
                                    token: data[1],
                                    url: data[2]);
                                Navigator.pop(context);
                              });
                            });
                          },
                        )
                      : OutlinedButton(
                          onPressed: null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.threeArchedCircle(
                                  color: Color(0xFFF05454), size: 20),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(S.of(context).loading)
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

  int tabIndex = 0;
  final sideBar_controller =
      SidebarXController(selectedIndex: 0, extended: true);

  void ChangeTabIndex(idx) {
    tabIndex = idx;
    //sideBar_controller.selectIndex(idx);
    emit(ChangedTabIndex());
  }

  Future<List> uploadImage({
    required dynamic image,
  }) async {
    notLoading();
    uploading();

    try {
      final tempDir = await getTemporaryDirectory();
      final now = DateTime.now();
      final name =
          '${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}-${now.second}';
      File file = await File('${tempDir.path}/image.jpg').create();

      if (image.runtimeType == XFile) {
        file = File(image.path);
      } else {
        file.writeAsBytesSync(image);
      }

      if (image != null) {
        final snapshot = await uploadFileToFirebase(file, name);
        final downloadUrl = await getDownloadUrl(snapshot);
        final token = parseTokenFromUrl(downloadUrl);

        print('url= $downloadUrl');
        doneUploading();
        return [name, token, downloadUrl];
      }

      doneUploading();
      return ["name", "token"];
    } catch (e) {
      print(e.toString());
      doneUploading();
      return ["name", "token"];
    }
  }

  Future<dynamic> uploadFileToFirebase(File file, String name) async {
    return await _firebaseStorage
        .ref()
        .child('images/${user.uid}/${name}')
        .putFile(file);
  }

  Future<String> getDownloadUrl(dynamic snapshot) async {
    return await snapshot.ref.getDownloadURL();
  }

  String parseTokenFromUrl(String downloadUrl) {
    const startWord = "token=";
    final startIndex = downloadUrl.indexOf(startWord);
    final endIndex = downloadUrl.length;
    return downloadUrl.substring(startIndex + startWord.length, endIndex);
  }

  void getTest({
    required String imgname,
    required String token,
    required String url,
  }) async {
    bodyIndex = 2;
    emit(WaitingResult());

    try {
      final res = await getApiRequest(imgname: imgname, token: token);
      test_result = res;
      final now = DateTime.now().millisecondsSinceEpoch;

      final imageData = {
        'name': imgname,
        'url': url,
        'result': res,
        'time': now,
      };
      await writeImageDataToDatabase(imageData, now.toString());

      emit(TestDone());
    } catch (e) {
      print(e.toString());
      emit(TestError());
    }
  }

  Future<void> writeImageDataToDatabase(
      Map<String, dynamic> imageData, String key) async {
    await dbRef.child(user.uid).child("images").child(key).set(imageData);
  }

  String buildUrl({
    required String baseUrl,
    required String imgname,
    required String token,
    required String uid,
  }) =>
      "$baseUrl?id=$imgname&token=$token&uid=$uid";

  Future<String> getApiRequest({
    required String imgname,
    required String token,
  }) async {
    final String url = buildUrl(
      baseUrl: apiHeroku,
      imgname: imgname,
      token: token,
      uid: user.uid,
    );
    print("api url=:$url");
    final dio = Dio();
    try {
      final response = await dio.get(url);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      throw e;
    }
  }

  void languageChanged({required newLang}) {
    if (newLang.name == "English") {
      S.load(const Locale('en', ''));
      selectedLanguage = languages[0];
      layoutDirection = TextDirection.ltr;
    } else {
      S.load(const Locale('ar', ''));
      selectedLanguage = languages[1];
      layoutDirection = TextDirection.rtl;
    }
    emit(ChangedLanguage());
  }

  Icon dropDownIcon = Icon(Icons.arrow_drop_down);
  bool isDown = true;

  void pressedRecord() {
    if (isDown) {
      dropDownIcon = Icon(Icons.arrow_drop_up);
      isDown = false;
    } else {
      isDown = true;
      dropDownIcon = Icon(Icons.arrow_drop_down);
    }
    emit(PressedRecord());
  }
}
