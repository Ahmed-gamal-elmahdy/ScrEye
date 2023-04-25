import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  bool isVisible = false;

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

  void submitRegistration() async {
    if (_email.isEmpty || !EmailValidator.validate(_email)) {
      emit(AuthenticationFailure('Please enter a valid email address'));
      return;
    }

    if (_password.isEmpty || _password.length < 6) {
      emit(AuthenticationFailure(
          'Please enter a password with at least 6 characters'));
      return;
    }

    if (_password != _passwordConfirm) {
      emit(AuthenticationFailure('Passwords do not match'));
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
        emit(AuthenticationFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthenticationFailure(
            'The account already exists for that email.'));
      }
    } catch (e) {
      emit(AuthenticationFailure('An unknown error occurred'));
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

  void submitLogin() async {
    if (_email.isEmpty || !EmailValidator.validate(_email)) {
      emit(AuthenticationFailure('Please enter a valid email address'));
      return;
    }

    if (_password.isEmpty || _password.length < 6) {
      emit(AuthenticationFailure(
          'Please enter a password with at least 6 characters'));
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
        emit(AuthenticationFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthenticationFailure('Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(AuthenticationFailure('An unknown error occurred'));
    }
  }
}
