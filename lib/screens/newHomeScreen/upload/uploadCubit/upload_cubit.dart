import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  bool _uploadInProgress = false;
  final _firebaseStorage = FirebaseStorage.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('users');
  final String _apiHeroku = "https://screye.herokuapp.com/api/v3/";
  final String _apiAzure =
      "https://screyeapi.azurewebsites.net/api/screyeapiv1/";
  final User? _user = FirebaseAuth.instance.currentUser;

  UploadCubit({String? imagePath})
      : super(imagePath != null
            ? UploadImageLoaded(imagePath)
            : const UploadInitial());

  bool get uploadInProgress => _uploadInProgress;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imagePath = pickedFile.path;
      emit(UploadImageLoaded(_imagePath!));
    }
  }

  Future<void> uploadImage(context) async {
    if (state is UploadImageLoaded && !_uploadInProgress) {
      _uploadInProgress = true;
      _imagePath = (state as UploadImageLoaded).imagePath;
      emit(UploadImageLoaded((state as UploadImageLoaded).imagePath));
      try {
        final tempDir = await getTemporaryDirectory();
        final now = DateTime.now();
        final name =
            '${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}-${now.second}';
        File file = await File('${tempDir.path}/image.jpg').create();

        file = File(_imagePath!);

        final snapshot = await uploadFileToFirebase(file, name);
        final downloadUrl = await getDownloadUrl(snapshot);
        final token = parseTokenFromUrl(downloadUrl);
        debugPrint('url= $downloadUrl');
        final result = await getResultAndUpdateDB(
            name: name, token: token, url: downloadUrl);
        if (_uploadInProgress) {
          _uploadInProgress = false;
          Navigator.popAndPushNamed(
            context,
            "/result",
            arguments: {'result': result},
          );
        } else {
          cancelUpload();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void _showResult(context, String result) {
    if (_uploadInProgress && result != '') {}
  }

  Future<dynamic> uploadFileToFirebase(File file, String name) async {
    return await _firebaseStorage
        .ref()
        .child('images/${_user?.uid}/$name')
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

  Future<String> getResultAndUpdateDB({
    required String name,
    required String token,
    required String url,
  }) async {
    if ((state is UploadImageLoaded && _uploadInProgress)) {
      try {
        final res = await getApiRequest(name: name, token: token);
        final now = DateTime.now().millisecondsSinceEpoch;
        final imageData = {
          'name': name,
          'url': url,
          'result': res,
          'time': now,
        };
        await writeImageDataToDatabase(imageData, now.toString());
        return res;
      } catch (e) {
        debugPrint(e.toString());
        return 'failed';
      }
    }
    return 'error';
  }

  Future<void> writeImageDataToDatabase(
      Map<String, dynamic> imageData, String key) async {
    await dbRef.child(_user!.uid).child("images").child(key).set(imageData);
  }

  Future<String> getApiRequest({
    required String name,
    required String token,
  }) async {
    final String url = buildUrl(
      baseUrl: _apiHeroku,
      imgname: name,
      token: token,
      uid: _user!.uid,
    );
    debugPrint("api url=:$url");
    final dio = Dio();
    if ((state is UploadImageLoaded && _uploadInProgress)) {
      try {
        final response = await dio.get(url);
        debugPrint(response.data);
        return response.data;
      } on DioException catch (e) {
        debugPrint(e.message);
        rethrow;
      }
    }
    return 'error';
  }

  String buildUrl({
    required String baseUrl,
    required String imgname,
    required String token,
    required String uid,
  }) =>
      "$baseUrl?id=$imgname&token=$token&uid=$uid";

  void cancelUpload() {
    _uploadInProgress = false;
    emit((UploadImageLoaded(_imagePath!)));
  }

  void discard() {
    _uploadInProgress = false;
    emit(const UploadInitial());
  }
}
