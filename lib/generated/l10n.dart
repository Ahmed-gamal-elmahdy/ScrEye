// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get lang {
    return Intl.message(
      'English',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailInputLabel {
    return Intl.message(
      'Email',
      name: 'emailInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordInputLabel {
    return Intl.message(
      'Password',
      name: 'passwordInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInActionText {
    return Intl.message(
      'Sign in',
      name: 'signInActionText',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerActionText {
    return Intl.message(
      'Register',
      name: 'registerActionText',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInButtonText {
    return Intl.message(
      'Sign in',
      name: 'signInButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButtonText {
    return Intl.message(
      'Register',
      name: 'registerButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequiredErrorText {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get isNotAValidEmailErrorText {
    return Intl.message(
      'Please enter a valid email',
      name: 'isNotAValidEmailErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This account does not exist`
  String get userNotFoundErrorText {
    return Intl.message(
      'This account does not exist',
      name: 'userNotFoundErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This email is already used`
  String get emailTakenErrorText {
    return Intl.message(
      'This email is already used',
      name: 'emailTakenErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Access to this account has been temporarily disabled`
  String get accessDisabledErrorText {
    return Intl.message(
      'Access to this account has been temporarily disabled',
      name: 'accessDisabledErrorText',
      desc: '',
      args: [],
    );
  }

  /// `The password is invalid or this user does not have a password`
  String get wrongOrNoPasswordErrorText {
    return Intl.message(
      'The password is invalid or this user does not have a password',
      name: 'wrongOrNoPasswordErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInText {
    return Intl.message(
      'Sign In',
      name: 'signInText',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get registerText {
    return Intl.message(
      'Create an account',
      name: 'registerText',
      desc: '',
      args: [],
    );
  }

  /// `You don't already have an account?`
  String get registerHintText {
    return Intl.message(
      'You don\'t already have an account?',
      name: 'registerHintText',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get signInHintText {
    return Intl.message(
      'Already have an account?',
      name: 'signInHintText',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOutButtonText {
    return Intl.message(
      'Sign Out',
      name: 'signOutButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequiredErrorText {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmPasswordIsRequiredErrorText {
    return Intl.message(
      'Confirm your password',
      name: 'confirmPasswordIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `The entered passwords do not match`
  String get confirmPasswordDoesNotMatchErrorText {
    return Intl.message(
      'The entered passwords do not match',
      name: 'confirmPasswordDoesNotMatchErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordInputLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPasswordButtonLabel {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPasswordButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgotten password recovery`
  String get forgotPasswordViewTitle {
    return Intl.message(
      'Forgotten password recovery',
      name: 'forgotPasswordViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButtonLabel {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password with at least 6 characters`
  String get passwordTooShort {
    return Intl.message(
      'Please enter a password with at least 6 characters',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get passwordTooWeak {
    return Intl.message(
      'The password provided is too weak.',
      name: 'passwordTooWeak',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Upload A Taken Image`
  String get taken_photo_upload {
    return Intl.message(
      'Upload A Taken Image',
      name: 'taken_photo_upload',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Align Clipper with Conjunctiva`
  String get align_clipper {
    return Intl.message(
      'Align Clipper with Conjunctiva',
      name: 'align_clipper',
      desc: '',
      args: [],
    );
  }

  /// `Take a test first to see your result!`
  String get take_test_first {
    return Intl.message(
      'Take a test first to see your result!',
      name: 'take_test_first',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navbar_home {
    return Intl.message(
      'Home',
      name: 'navbar_home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get navbar_profile {
    return Intl.message(
      'Profile',
      name: 'navbar_profile',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get navbar_history {
    return Intl.message(
      'History',
      name: 'navbar_history',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get navbar_settings {
    return Intl.message(
      'Settings',
      name: 'navbar_settings',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `You are:`
  String get you_are {
    return Intl.message(
      'You are:',
      name: 'you_are',
      desc: '',
      args: [],
    );
  }

  /// `Anemic`
  String get anemic {
    return Intl.message(
      'Anemic',
      name: 'anemic',
      desc: '',
      args: [],
    );
  }

  /// `Not Anemic`
  String get not_anemic {
    return Intl.message(
      'Not Anemic',
      name: 'not_anemic',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait..`
  String get pls_wait {
    return Intl.message(
      'Please Wait..',
      name: 'pls_wait',
      desc: '',
      args: [],
    );
  }

  /// `Capturing..`
  String get capturing {
    return Intl.message(
      'Capturing..',
      name: 'capturing',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Image saved for later use`
  String get img_saved_later {
    return Intl.message(
      'Image saved for later use',
      name: 'img_saved_later',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `Image Discarded`
  String get img_discarded {
    return Intl.message(
      'Image Discarded',
      name: 'img_discarded',
      desc: '',
      args: [],
    );
  }

  /// `Your Image`
  String get your_img {
    return Intl.message(
      'Your Image',
      name: 'your_img',
      desc: '',
      args: [],
    );
  }

  /// `New to ScrEye?`
  String get new_to_screye {
    return Intl.message(
      'New to ScrEye?',
      name: 'new_to_screye',
      desc: '',
      args: [],
    );
  }

  /// `Already a ScrEye user?`
  String get already_user {
    return Intl.message(
      'Already a ScrEye user?',
      name: 'already_user',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
