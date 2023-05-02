import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/themes/MyTheme.dart' show MyTheme, ThemeMode;

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit()
      : super(AppSettingsState(
            theme: MyTheme.whiteTheme(),
            locale: Locale('en'),
            directionality: TextDirection.ltr,
            themeMode: ThemeMode.originalTheme));

  void updateTheme(ThemeMode themeMode) {
    emit(state.copyWith(
        theme: MyTheme.getTheme(themeMode), themeMode: themeMode));
  }

  void updateLocale(Locale locale) {
    final directionality = _getDirectionality(locale);
    emit(state.copyWith(locale: locale, directionality: directionality));
  }

  TextDirection _getDirectionality(Locale locale) {
    if (locale.languageCode == "en") {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }
}
