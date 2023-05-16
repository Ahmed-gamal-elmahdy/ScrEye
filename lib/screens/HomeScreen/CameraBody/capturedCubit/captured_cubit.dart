import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'captured_state.dart';

class CapturedCubit extends Cubit<CapturedState> {
  CapturedCubit() : super(CapturedState());

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

  void updateAdditionalInfo(String additionalInfo) {
    emit(state.copyWith(additionalInfo: additionalInfo));
  }

  void updateImage(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void saveCaptured() {
    final _userRef =
        FirebaseDatabase.instance.ref().child('users').child(_user!.uid);
  }
}
