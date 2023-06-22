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
              S.of(context).themes,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            color: Colors.white,
            child: RadioListTile<ThemeMode>(
              title: Text(S.of(context).white_theme),
              value: ThemeMode.whiteTheme,
              groupValue: settingsCubit.state.themeMode,
              onChanged: (value) {
                settingsCubit.updateTheme(value!);
              },
            ),
          ),
          /*
          Container(
            color: Colors.white,
            child: RadioListTile<ThemeMode>(
              title: Text(S.of(context).dark_theme),
              value: ThemeMode.originalTheme,
              groupValue: settingsCubit.state.themeMode,
              onChanged: (value) {
                settingsCubit.updateTheme(value!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              thickness: 2,
            ),
          ),
           */
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
