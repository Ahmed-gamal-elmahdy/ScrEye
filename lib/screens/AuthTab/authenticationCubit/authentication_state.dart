
part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

//Global authentication
class AuthenticationInitial extends AuthenticationState {
}
class AuthenticationWithLanguage extends AuthenticationState {
  final Language language;

  AuthenticationWithLanguage(this.language);
}



class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailure(this.errorMessage);
}

class LanguageChanged extends AuthenticationState {}
class PasswordVisibilityChanged extends AuthenticationState {}
//Register
class RegistrationInitial extends AuthenticationState {}

class RegistrationLoading extends AuthenticationState {}

class RegistrationSuccess extends AuthenticationState {}

//Login
class LoginInitial extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginSuccess extends AuthenticationState {}

// Define the different events that can be triggered by the widget
abstract class AuthenticationEvent {}

//Registration
class RegistrationSubmit extends AuthenticationEvent {}

class RegistrationEmailChanged extends AuthenticationEvent {
  final String email;

  RegistrationEmailChanged(this.email);
}

class RegistrationPasswordChanged extends AuthenticationEvent {
  final String password;

  RegistrationPasswordChanged(this.password);
}

class RegistrationPasswordConfirmChanged extends AuthenticationEvent {
  final String passwordConfirm;

  RegistrationPasswordConfirmChanged(this.passwordConfirm);
}
//Login

class LoginSubmit extends AuthenticationEvent {}

class LoginEmailChanged extends AuthenticationEvent {
  final String email;

  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends AuthenticationEvent {
  final Language lang;

  LoginPasswordChanged(this.lang);
}
