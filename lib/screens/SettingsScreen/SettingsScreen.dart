import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/AppSettingsCubit/app_settings_cubit.dart';
import 'package:fluttertest/themes/MyTheme.dart' show ThemeMode;

import '../../generated/l10n.dart';
import '../../widgets/MyDrawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsCubit = BlocProvider.of<AppSettingsCubit>(context);
    final appLocalizations = S.of(context);

    return Scaffold(
      drawer: myDrawer(context),
      appBar: AppBar(
        title: Text(appLocalizations.navbar_settings),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "THEME",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          RadioListTile<ThemeMode>(
            title: Text("White theme"),
            value: ThemeMode.whiteTheme,
            groupValue: settingsCubit.state.themeMode,
            onChanged: (value) {
              settingsCubit.updateTheme(value!);
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text("Original Theme"),
            value: ThemeMode.originalTheme,
            groupValue: settingsCubit.state.themeMode,
            onChanged: (value) {
              settingsCubit.updateTheme(value!);
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appLocalizations.language,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<Locale>(
                  value: settingsCubit.state.locale,
                  items: S.delegate.supportedLocales
                      .map((locale) => DropdownMenuItem<Locale>(
                            value: locale,
                            child: Row(
                              children: [
                                Flag.fromString(
                                    locale.languageCode == 'ar' ? 'EG' : "US",
                                    height: 25.h,
                                    width: 50.w),
                                Text(locale.languageCode == 'ar'
                                    ? appLocalizations.ar
                                    : appLocalizations.en),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    settingsCubit.updateLocale(value!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}