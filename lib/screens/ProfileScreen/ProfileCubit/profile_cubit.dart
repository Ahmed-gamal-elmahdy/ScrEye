import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/widgets/mySnackBar.dart';

import '../../../generated/l10n.dart';
import '../../AuthScreen/reauth_dialog.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final User? _user = FirebaseAuth.instance.currentUser;

  ProfileCubit() : super(const ProfileLoading()) {
    fetchProfileData();
  }

  void fetchProfileData() async {
    final userRef =
        FirebaseDatabase.instance.ref().child('users').child(_user!.uid);
    final dataSnapshot = await userRef.once();
    final userData = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
    final name = userData['name'] ?? '';
    final email = userData['email'] ?? '';
    final password = '';
    final age = userData['age'] ?? '';
    final gender = userData['gender'];
    const visibility = false;

    emit(ProfileLoaded(
      name: name,
      email: email,
      password: password,
      age: age,
      gender: gender,
      visibility: visibility,
    ));
  }

  void updateVisibility(context, bool visibility) {
    try {
      emit(state.copyWith(visibility: visibility));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(
          context, 'Error updating visibility: $error', SnackBarType.error);
    }
  }

  void updateName(context, String name) {
    try {
      emit(state.copyWith(name: name));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(context, 'Error updating name: $error', SnackBarType.error);
    }
  }

  void updateEmail(context, String email) {
    try {
      emit(state.copyWith(email: email));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(context, 'Error updating email: $error', SnackBarType.error);
    }
  }

  void updatePassword(context, String password) {
    try {
      emit(state.copyWith(password: password));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(
          context, 'Error updating password: $error', SnackBarType.error);
    }
  }

  void updateAge(context, int age) {
    try {
      emit(state.copyWith(age: age));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(context, 'Error updating age: $error', SnackBarType.error);
    }
  }

  void updateGender(context, String gender) {
    try {
      emit(state.copyWith(gender: gender));
    } catch (error) {
      emit(state); // Revert back to the previous state
      // Handle the error by showing a message or logging it
      showSnackBar(
          context, 'Error updating gender: $error', SnackBarType.error);
    }
  }

  Future<void> askConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return ReauthenticationDialog(
          message: S.of(context).auth_pass_required_hint,
        );
      },
    );
    if (result != null && result == true) {
      saveChanges(context);
    } else {}
  }

  void saveChanges(BuildContext context) async {
    try {
      final dbref =
          FirebaseDatabase.instance.ref().child('users').child(_user!.uid);
      // Save the profile data to Firebase Firestore
      if (state.email != "") {
        _user!.updateEmail(state.email);
        dbref.update({
          'email': state.email,
        });
      }
      if (state.name != "") {
        _user!.updateDisplayName(state.name);
        dbref.update({
          'name': state.name,
        });
      }
      if (state.password != "") {
        _user!.updatePassword(state.password);
      }
      dbref.update({
        'age': state.age,
        'gender': state.gender,
      });
      // Show a success message
      showSnackBar(
          context, S.of(context).profile_saved_success, SnackBarType.success);
      Navigator.of(context).pop();
      // Emit the ProfileSaved state
      emit(const ProfileSaved());
    } catch (error) {
      // Show an error message
      showSnackBar(
          context, S.of(context).profile_saved_fail, SnackBarType.error);
    }
  }
}
