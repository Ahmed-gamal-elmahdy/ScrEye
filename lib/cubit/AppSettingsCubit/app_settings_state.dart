part of 'app_settings_cubit.dart';

class AppSettingsState {
  final ThemeData theme;
  final Locale locale;
  final TextDirection directionality;
  final ThemeMode themeMode;

  const AppSettingsState(
      {required this.theme,
      required this.locale,
      required this.directionality,
      required this.themeMode});

  AppSettingsState copyWith(
      {ThemeData? theme,
      Locale? locale,
      TextDirection? directionality,
      ThemeMode? themeMode}) {
    return AppSettingsState(
        theme: theme ?? this.theme,
        locale: locale ?? this.locale,
        directionality: directionality ?? this.directionality,
        themeMode: themeMode ?? this.themeMode);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsState &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          locale == other.locale &&
          directionality == other.directionality &&
          themeMode == other.themeMode;

  @override
  int get hashCode =>
      theme.hashCode ^
      locale.hashCode ^
      directionality.hashCode ^
      themeMode.hashCode;
}
