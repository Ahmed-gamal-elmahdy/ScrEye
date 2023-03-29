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

  /// `البريد الإلكتروني مطلوب`
  String get emailIsRequiredErrorText {
    return Intl.message(
      'البريد الإلكتروني مطلوب',
      name: 'emailIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `رجاء قم بإدخال بريد إلكتروني صالح`
  String get isNotAValidEmailErrorText {
    return Intl.message(
      'رجاء قم بإدخال بريد إلكتروني صالح',
      name: 'isNotAValidEmailErrorText',
      desc: '',
      args: [],
    );
  }

  /// `هذا الحساب غير موجود`
  String get userNotFoundErrorText {
    return Intl.message(
      'هذا الحساب غير موجود',
      name: 'userNotFoundErrorText',
      desc: '',
      args: [],
    );
  }

  /// `هذا البريد الإلكتروني مستخدم مسبقاً`
  String get emailTakenErrorText {
    return Intl.message(
      'هذا البريد الإلكتروني مستخدم مسبقاً',
      name: 'emailTakenErrorText',
      desc: '',
      args: [],
    );
  }

  /// `تم تعطيل الوصول إلى هذا الحساب مؤقتًا`
  String get accessDisabledErrorText {
    return Intl.message(
      'تم تعطيل الوصول إلى هذا الحساب مؤقتًا',
      name: 'accessDisabledErrorText',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور غير صالحة أو أن هذا المستخدم ليس لديه كلمة مرور`
  String get wrongOrNoPasswordErrorText {
    return Intl.message(
      'كلمة المرور غير صالحة أو أن هذا المستخدم ليس لديه كلمة مرور',
      name: 'wrongOrNoPasswordErrorText',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول`
  String get signInText {
    return Intl.message(
      'تسجيل الدخول',
      name: 'signInText',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء حساب`
  String get registerText {
    return Intl.message(
      'إنشاء حساب',
      name: 'registerText',
      desc: '',
      args: [],
    );
  }

  /// `ليس لديك حساب مسبقا؟`
  String get registerHintText {
    return Intl.message(
      'ليس لديك حساب مسبقا؟',
      name: 'registerHintText',
      desc: '',
      args: [],
    );
  }

  /// `لديك حساب مسبقا؟`
  String get signInHintText {
    return Intl.message(
      'لديك حساب مسبقا؟',
      name: 'signInHintText',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الخروج`
  String get signOutButtonText {
    return Intl.message(
      'تسجيل الخروج',
      name: 'signOutButtonText',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور مطلوبة`
  String get passwordIsRequiredErrorText {
    return Intl.message(
      'كلمة المرور مطلوبة',
      name: 'passwordIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `قم بتأكيد كلمة مرورك`
  String get confirmPasswordIsRequiredErrorText {
    return Intl.message(
      'قم بتأكيد كلمة مرورك',
      name: 'confirmPasswordIsRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `كلمات المرور المدخلة غير متطابقة`
  String get confirmPasswordDoesNotMatchErrorText {
    return Intl.message(
      'كلمات المرور المدخلة غير متطابقة',
      name: 'confirmPasswordDoesNotMatchErrorText',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد كلمة المرور`
  String get confirmPasswordInputLabel {
    return Intl.message(
      'تأكيد كلمة المرور',
      name: 'confirmPasswordInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `نسيت كلمة المرور؟`
  String get forgotPasswordButtonLabel {
    return Intl.message(
      'نسيت كلمة المرور؟',
      name: 'forgotPasswordButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `استرجاع كلمة المرور المنسية`
  String get forgotPasswordViewTitle {
    return Intl.message(
      'استرجاع كلمة المرور المنسية',
      name: 'forgotPasswordViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `إعادة تعيين كلمة المرور`
  String get resetPasswordButtonLabel {
    return Intl.message(
      'إعادة تعيين كلمة المرور',
      name: 'resetPasswordButtonLabel',
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
