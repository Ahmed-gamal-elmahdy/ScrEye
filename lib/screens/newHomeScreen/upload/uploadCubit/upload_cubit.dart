import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  bool _uploadInProgress = false;
  bool _segmentationInProgress = false;
  bool _isSegmented = false;
  final _firebaseStorage = FirebaseStorage.instance;
  final dbRef = FirebaseDatabase.instance.ref().child('users');
  final String _apiHeroku =
      "https://screyeapi-acb90b2a628c.herokuapp.com/api/v3/";
  final String _apiHerokuSegmentation =
      "https://screyeapi-acb90b2a628c.herokuapp.com/api/segment/v2/";
  final String _apiAzure =
      "https://screyeapi.azurewebsites.net/api/screyeapiv1/";
  final User? _user = FirebaseAuth.instance.currentUser;

  UploadCubit({String? imagePath})
      : super(imagePath != null
            ? UploadImageLoaded(imagePath)
            : const UploadInitial());

  bool get uploadInProgress => _uploadInProgress;

  bool get isSegmented => _isSegmented;

  bool get segmentationInProgress => _segmentationInProgress;

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

        final snapshot = await _uploadFileToFirebase(file, name);
        final downloadUrl = await _getDownloadUrl(snapshot);
        final token = _parseTokenFromUrl(downloadUrl);
        debugPrint('url= $downloadUrl');
        final result = await _getResultAndUpdateDB(
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

  Future<dynamic> _uploadFileToFirebase(File file, String name) async {
    return await _firebaseStorage
        .ref()
        .child('images/${_user?.uid}/$name')
        .putFile(file);
  }

  Future<String> _getDownloadUrl(dynamic snapshot) async {
    return await snapshot.ref.getDownloadURL();
  }

  String _parseTokenFromUrl(String downloadUrl) {
    const startWord = "token=";
    final startIndex = downloadUrl.indexOf(startWord);
    final endIndex = downloadUrl.length;
    return downloadUrl.substring(startIndex + startWord.length, endIndex);
  }

  Future<String> _getResultAndUpdateDB({
    required String name,
    required String token,
    required String url,
  }) async {
    if ((state is UploadImageLoaded && _uploadInProgress)) {
      try {
        final res = await _getApiRequest(name: name, token: token);
        final now = DateTime.now().millisecondsSinceEpoch;
        final imageData = {
          'name': name,
          'url': url,
          'result': res,
          'time': now,
        };
        await _writeImageDataToDatabase(imageData, now.toString());
        return res;
      } catch (e) {
        debugPrint(e.toString());
        return 'failed';
      }
    }
    return 'error';
  }

  Future<void> _writeImageDataToDatabase(
      Map<String, dynamic> imageData, String key) async {
    await dbRef.child(_user!.uid).child("images").child(key).set(imageData);
  }

  Future<String> _getApiRequest({
    required String name,
    required String token,
  }) async {
    final String url = _buildUrl(
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

  Future<void> getSegmented() async {
    if (state is UploadImageLoaded &&
        !_segmentationInProgress &&
        !_isSegmented) {
      _segmentationInProgress = true;
      _imagePath = (state as UploadImageLoaded).imagePath;
      emit(UploadImageLoaded((state as UploadImageLoaded).imagePath));

      final tempDir = await getTemporaryDirectory();
      final now = DateTime.now();
      final name =
          '${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}-${now.second}';
      File file = await File('${tempDir.path}/image.jpg').create();

      file = File(_imagePath!);

      final snapshot = await _uploadFileToFirebase(file, name);
      final downloadUrl = await _getDownloadUrl(snapshot);
      final token =  _parseTokenFromUrl(downloadUrl);
      debugPrint('url= $downloadUrl');

      final String url = _buildUrl(
        baseUrl: _apiHerokuSegmentation,
        imgname: name,
        token: token,
        uid: _user!.uid,
      );
      debugPrint('Api url= $url');
      var dio = Dio();
      try {
        await dio.get(url).then((_) => {
        Future.delayed(const Duration(seconds: 0),() async {
        var result = await  FirebaseStorage.instance
            .ref()
            .child('${_user?.uid}segmeneted.jpg')
            .getDownloadURL();
        final tempDir = await getTemporaryDirectory();
        final now = DateTime.now().millisecondsSinceEpoch;
        File tempFile = await File('${tempDir.path}/$now.jpg').create();
        await dio.download(result, tempFile.path);
        _imagePath = tempFile.path;
        _isSegmented = true;

        if (_segmentationInProgress) {
        cancelSegmentation();
        }
        })
        });





      } catch (e) {
        debugPrint('Error uploading image: $e');
      }
    }
  }

  String _buildUrl({
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

  void cancel() {
    if (_isSegmented) {
      if (_uploadInProgress) {
        cancelUpload();
      } else {
        discard();
      }
    } else {
      if (_segmentationInProgress) {
        cancelSegmentation();
      } else {
        if (_uploadInProgress) {
          cancelUpload();
        } else {
          discard();
        }
      }
    }
  }

  void cancelSegmentation() {
    _segmentationInProgress = false;
    emit((UploadImageLoaded(_imagePath!)));
  }

  Future<void> saveImage() async {
    final imagePath = _imagePath = (state as UploadImageLoaded).imagePath;
    final tempDir = await getTemporaryDirectory();
    final now = DateTime.now();
    final name =
        '${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}-${now.second}';
    final file = await File('${tempDir.path}/$name.jpg').create();
    await file.writeAsBytes(await File(imagePath!).readAsBytes());
    final result = await GallerySaver.saveImage(file.path, albumName: "ScrEye");
    if (result == true) {
      debugPrint('Image saved to gallery.');
    } else {
      debugPrint('Error saving image: ');
    }
  }

  void discard() {
    _uploadInProgress = false;
    _segmentationInProgress = false;
    _isSegmented = false;
    emit(const UploadInitial());
  }
}
