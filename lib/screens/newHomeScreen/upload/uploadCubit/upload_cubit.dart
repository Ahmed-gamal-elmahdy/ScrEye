import 'dart:io';

import 'package:bloc/bloc.dart';
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

  Future<void> uploadImage() async {
    if (state is UploadImageLoaded && !_uploadInProgress) {
      _uploadInProgress = true;
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
      } catch (e) {
        debugPrint(e.toString());
      }
      cancelUpload();
    }
  }

  Future<dynamic> uploadFileToFirebase(File file, String name) async {
    return await _firebaseStorage
        .ref()
        .child('images/${FirebaseAuth.instance.currentUser?.uid}/$name')
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

  void cancelUpload() {
    _uploadInProgress = false;
    _imagePath = null;
    emit(const UploadInitial());
  }
}
