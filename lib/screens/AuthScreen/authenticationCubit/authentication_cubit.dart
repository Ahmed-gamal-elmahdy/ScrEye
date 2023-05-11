import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/Language.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  bool isVisible = false;
  List<Language> languages = [
    const Language(name: "English", code: "US"),
    const Language(name: "العربية", code: "EG"),
  ];
  Language? selectedLanguage;
  TextDirection? layoutDirection;

  AuthenticationCubit() : super(AuthenticationInitial()) {
    if (S.current.lang == "English") {
      selectedLanguage = languages[0];
      layoutDirection = TextDirection.ltr;
    } else {
      selectedLanguage = languages[1];
      layoutDirection = TextDirection.rtl;
    }
  }

  void languageChanged(newLang) {
    if (newLang.name == "English") {
      S.load(const Locale('en', ''));
      selectedLanguage = languages[0];
      layoutDirection = TextDirection.ltr;
    } else {
      S.load(const Locale('ar', ''));
      selectedLanguage = languages[1];
      layoutDirection = TextDirection.rtl;
    }
    emit(LanguageChanged());
  }

  void visibilityChanged() {
    isVisible = isVisible ? false : true;
    emit(PasswordVisibilityChanged());
  }

  //Register
  void emailChangedRegister(String email) {
    _email = email;
    emit(RegistrationInitial());
  }

  void passwordChangedRegister(String password) {
    _password = password;
    emit(RegistrationInitial());
  }

  void passwordConfirmChangedRegister(String passwordConfirm) {
    _passwordConfirm = passwordConfirm;
    emit(RegistrationInitial());
  }

  void submitRegistration(context) async {
    if (_email.isEmpty || !EmailValidator.validate(_email)) {
      emit(AuthenticationFailure(S
          .of(context)
          .isNotAValidEmailErrorText));
      return;
    }

    if (_password.isEmpty || _password.length < 6) {
      emit(AuthenticationFailure(S
          .of(context)
          .passwordTooShort));
      return;
    }

    if (_password != _passwordConfirm) {
      emit(AuthenticationFailure(
          S
              .of(context)
              .confirmPasswordDoesNotMatchErrorText));
      return;
    }

    emit(RegistrationLoading());

    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      Map<String, String?> user = {
        'name': "",
        "age": "",
        'gender': "Male",
        'email': userCredential.user?.email,
        'uid': userCredential.user?.uid,
        //'phoneNumber':state.credential.user?.phoneNumber
      };
      if (userCredential.user?.uid != null) {
        var uid = userCredential.user?.uid;
        FirebaseDatabase.instance.ref().child('users').child(uid!).set(user);
      }
      // Navigate to the home screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthenticationFailure(S
            .of(context)
            .passwordTooWeak));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthenticationFailure(S
            .of(context)
            .emailTakenErrorText));
      }
    } catch (e) {
      emit(AuthenticationFailure(S
          .of(context)
          .unknownError));
    }
  }

  //Login
  void emailChangedLogin(String email) {
    _email = email;
    emit(LoginInitial());
  }

  void passwordChangedLogin(String password) {
    _password = password;
    emit(LoginInitial());
  }

  void submitLogin(context) async {
    if (_email.isEmpty || !EmailValidator.validate(_email)) {
      emit(AuthenticationFailure(S
          .of(context)
          .isNotAValidEmailErrorText));
      return;
    }

    if (_password.isEmpty || _password.length < 6) {
      emit(AuthenticationFailure(S
          .of(context)
          .wrongOrNoPasswordErrorText));
      return;
    }

    emit(RegistrationLoading());
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // Navigate to the home screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthenticationFailure(S
            .of(context)
            .userNotFoundErrorText));
      } else if (e.code == 'wrong-password') {
        emit(AuthenticationFailure(S
            .of(context)
            .wrongOrNoPasswordErrorText));
      }
    } catch (e) {
      emit(AuthenticationFailure(S
          .of(context)
          .unknownError));
    }
  }
}
