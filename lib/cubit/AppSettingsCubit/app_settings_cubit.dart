import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/themes/MyTheme.dart' show MyTheme, ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  bool isOnline = false;
  late SharedPreferences _prefs;

  AppSettingsCubit()
      : super(AppSettingsState(
            theme: MyTheme.whiteTheme(),
            locale: Locale('en'),
            directionality: TextDirection.ltr,
            themeMode: ThemeMode.whiteTheme)) {
    _init();
  }

  Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    isOnline = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
    return isOnline;
  }

  void updateTheme(ThemeMode themeMode) {
    emit(state.copyWith(
        theme: MyTheme.getTheme(themeMode), themeMode: themeMode));
    _updatePrefs();
  }

  ThemeMode currentTheme() => state.themeMode;

  void updateLocale(Locale locale) {
    final directionality = _getDirectionality(locale);
    emit(state.copyWith(locale: locale, directionality: directionality));
    _updatePrefs();
  }

  TextDirection _getDirectionality(Locale locale) =>
      locale.languageCode == "en" ? TextDirection.ltr : TextDirection.rtl;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final themeString = _prefs.getString('Theme');
    if (themeString == "ThemeMode.darkTheme") {
      updateTheme(ThemeMode.darkTheme);
    } else if (themeString == "ThemeMode.whiteTheme") {
      updateTheme(ThemeMode.whiteTheme);
    } else if (themeString == "ThemeMode.monochromacyTheme") {
      updateTheme(ThemeMode.monochromacyTheme);
    }

    final localeString = _prefs.getString('Locale');
    final locale =
        localeString == "en" ? const Locale("en") : const Locale("ar");
    updateLocale(locale);
  }

  Future<void> _updatePrefs() async {
    await _prefs.setString('Theme', state.themeMode.toString());
    await _prefs.setString('Locale', state.locale.toString());
  }
}
