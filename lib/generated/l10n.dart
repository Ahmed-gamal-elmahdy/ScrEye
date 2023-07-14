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

  /// `Aligh with Conjunctiva`
  String get align_clipper {
    return Intl.message(
      'Aligh with Conjunctiva',
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

  /// `New to ScrEye? `
  String get new_to_screye {
    return Intl.message(
      'New to ScrEye? ',
      name: 'new_to_screye',
      desc: '',
      args: [],
    );
  }

  /// `Already a ScrEye user? `
  String get already_user {
    return Intl.message(
      'Already a ScrEye user? ',
      name: 'already_user',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get ar {
    return Intl.message(
      'العربية',
      name: 'ar',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Verification failed. Please try again.`
  String get authError {
    return Intl.message(
      'Verification failed. Please try again.',
      name: 'authError',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get auth {
    return Intl.message(
      'Verification',
      name: 'auth',
      desc: '',
      args: [],
    );
  }

  /// `Enter the current password to save changes`
  String get auth_pass_required_hint {
    return Intl.message(
      'Enter the current password to save changes',
      name: 'auth_pass_required_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm settings`
  String get confirm_settings {
    return Intl.message(
      'Confirm settings',
      name: 'confirm_settings',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_saved_success {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_saved_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get profile_saved_fail {
    return Intl.message(
      'Failed to update profile',
      name: 'profile_saved_fail',
      desc: '',
      args: [],
    );
  }

  /// `No data found`
  String get history_empty_error {
    return Intl.message(
      'No data found',
      name: 'history_empty_error',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get themes {
    return Intl.message(
      'Themes',
      name: 'themes',
      desc: '',
      args: [],
    );
  }

  /// `White Theme`
  String get white_theme {
    return Intl.message(
      'White Theme',
      name: 'white_theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get dark_theme {
    return Intl.message(
      'Dark Theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Color Blind Theme`
  String get colorblind_theme {
    return Intl.message(
      'Color Blind Theme',
      name: 'colorblind_theme',
      desc: '',
      args: [],
    );
  }

  /// `Not connected to internet`
  String get internet_error {
    return Intl.message(
      'Not connected to internet',
      name: 'internet_error',
      desc: '',
      args: [],
    );
  }

  /// `Collect Data`
  String get collect_data {
    return Intl.message(
      'Collect Data',
      name: 'collect_data',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get undefined {
    return Intl.message(
      'N/A',
      name: 'undefined',
      desc: '',
      args: [],
    );
  }

  /// `Additional Info`
  String get additional_info {
    return Intl.message(
      'Additional Info',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `Choose Files..`
  String get choose_files {
    return Intl.message(
      'Choose Files..',
      name: 'choose_files',
      desc: '',
      args: [],
    );
  }

  /// `Anemic`
  String get anemic_data {
    return Intl.message(
      'Anemic',
      name: 'anemic_data',
      desc: '',
      args: [],
    );
  }

  /// `Non Anemic`
  String get not_anemic_data {
    return Intl.message(
      'Non Anemic',
      name: 'not_anemic_data',
      desc: '',
      args: [],
    );
  }

  /// `Uploading..`
  String get uploading {
    return Intl.message(
      'Uploading..',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Upload form segmented folder only`
  String get upload_folder_error {
    return Intl.message(
      'Upload form segmented folder only',
      name: 'upload_folder_error',
      desc: '',
      args: [],
    );
  }

  /// `Test Mode`
  String get test_mode_lbl {
    return Intl.message(
      'Test Mode',
      name: 'test_mode_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Collection Mode`
  String get collection_mode_lbl {
    return Intl.message(
      'Collection Mode',
      name: 'collection_mode_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Choose an image`
  String get choose_img {
    return Intl.message(
      'Choose an image',
      name: 'choose_img',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Case`
  String get case_lbl {
    return Intl.message(
      'Case',
      name: 'case_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Add info`
  String get add_info {
    return Intl.message(
      'Add info',
      name: 'add_info',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Signing in...`
  String get login_progress {
    return Intl.message(
      'Signing in...',
      name: 'login_progress',
      desc: '',
      args: [],
    );
  }

  /// `Registering...`
  String get register_progress {
    return Intl.message(
      'Registering...',
      name: 'register_progress',
      desc: '',
      args: [],
    );
  }

  /// `Segment`
  String get segment {
    return Intl.message(
      'Segment',
      name: 'segment',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get analyze {
    return Intl.message(
      'Test',
      name: 'analyze',
      desc: '',
      args: [],
    );
  }

  /// `Switch`
  String get switch_camera {
    return Intl.message(
      'Switch',
      name: 'switch_camera',
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
