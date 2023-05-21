import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
part 'captured_state.dart';

class CapturedCubit extends Cubit<CapturedState> {
  CapturedCubit() : super(CapturedState.initial());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  final User? _user = FirebaseAuth.instance.currentUser;

  void updateAge(int age) {
    emit(state.copyWith(age: age));
  }

  void updateGender(String? gender) {
    emit(state.copyWith(gender: gender));
  }
  void updateAnemic(String? anemic) {
    emit(state.copyWith(anemic: anemic));
  }

  void updateAdditionalInfo(String additionalInfo) {
    emit(state.copyWith(additionalInfo: additionalInfo));
  }

  void updateImage(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }
  void updateFiles(FilePickerResult files) {
    emit(state.copyWith(files: files));
  }

  Future<void> chooseFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true);

    if (result != null) {
      updateFiles(result);
    } else {

    }
  }





  Future<void> saveCaptured() async {
    try {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final userStorageRef = FirebaseStorage.instance.ref('dataset/${_user!.uid}');
      final userDatasetRef = FirebaseFirestore.instance.collection('users').doc(_user!.uid);


      final imageUrl = await uploadImage(userStorageRef.child(timestamp), state.imagePath);
      final filesUrls = await uploadFiles(userStorageRef.child(timestamp));

      final data = {
        'name': state.name,
        'age': state.age,
        'gender': state.gender,
        'anemic': state.anemic,
        'info': state.additionalInfo,
        'imageUrl': imageUrl,
        'filesUrls': filesUrls,
      };

      await userDatasetRef.collection('data').doc(timestamp).set(data);

      emit(CapturedState.initial());
    } catch (error) {
      print(error);
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> saveCapturedRealtimeDB() async {
    try {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final userStorageRef = FirebaseStorage.instance.ref('dataset/${_user!.uid}');
      final userDatasetRef = FirebaseDatabase.instance.ref('dataset/${_user!.uid}/');


      final imageUrl = await uploadImage(userStorageRef.child(timestamp), state.imagePath);
      final filesUrls = await uploadFiles(userStorageRef.child(timestamp));

      final data = {
        'name': state.name,
        'age': state.age,
        'gender': state.gender,
        'anemic': state.anemic,
        'info': state.additionalInfo,
        'imageUrl': imageUrl,
        'filesUrls': filesUrls,
      };
      await userDatasetRef.child(timestamp).set(data);

      emit(CapturedState.initial());
    } catch (error) {
      print(error);
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<String> uploadImage(Reference ref, String path) async {
    final snapshot = await ref.child('image').putFile(File(path));
    return snapshot.ref.getDownloadURL();
  }

  Future<List<Future<String>>> uploadFiles(Reference ref) async {
    final tasks = state.files.files
        .map((file) => ref.child('files/').child(path.basename(file.path!)).putFile(File(file.path!)))
        .toList();
    final snapshots = await Future.wait(tasks);
    return snapshots.map((s) => s.ref.getDownloadURL()).toList();
  }


}
