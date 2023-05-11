import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final User? _user = FirebaseAuth.instance.currentUser;
  bool isVisible = false;

  ProfileCubit() : super(const ProfileLoading()) {
    fetchProfileData();
  }

  void fetchProfileData() async {
    final userRef =
        FirebaseDatabase.instance.ref().child('users').child(_user!.uid);
    final dataSnapshot = await userRef.once();
    final userData = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
    final name = _user?.displayName ?? '';
    final email = _user!.email!;
    final password = '';
    final age = userData['age'];
    final gender = userData['gender'];

    emit(ProfileLoaded(
      name: name,
      email: email,
      password: password,
      age: age,
      gender: gender,
    ));
  }

  void updateName(String name) {
    try {
      emit(state.copyWith(name: name));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      print('Error updating name: $error');
    }
  }

  void updateEmail(String email) {
    try {
      emit(state.copyWith(email: email));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      print('Error updating email: $error');
    }
  }

  void updatePassword(String password) {
    try {
      emit(state.copyWith(password: password));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      print('Error updating password: $error');
    }
  }

  void updateAge(int age) {
    try {
      emit(state.copyWith(age: age));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      print('Error updating age: $error');
    }
  }

  void updateGender(String gender) {
    try {
      emit(state.copyWith(gender: gender));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      print('Error updating gender: $error');
    }
  }

  void saveChanges(BuildContext context) async {
    try {
      // Save the profile data to Firebase Firestore
      FirebaseDatabase.instance.ref().child('users').child(_user!.uid).update({
        'name': state.name,
        'email': state.email,
        'age': state.age,
        'gender': state.gender,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved')),
      );
      Navigator.of(context).pop();
      // Emit the ProfileSaved state
      emit(ProfileSaved());
    } catch (error) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save profile')),
      );
    }
  }
}
