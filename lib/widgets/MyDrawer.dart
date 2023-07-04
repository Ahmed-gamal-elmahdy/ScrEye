import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/MyTheme.dart';
import '../cubit/AppSettingsCubit/app_settings_cubit.dart';
import '../generated/l10n.dart';

Drawer myDrawer(context) {
  var settingCubit = BlocProvider.of<AppSettingsCubit>(context);
  var bg = 'assets/logo_3_dark.png';
  if (settingCubit.state.themeMode == ThemeMode.whiteTheme) {
    bg = 'assets/logo_3.png';
  } else if (settingCubit.state.themeMode == ThemeMode.darkTheme) {
    bg = 'assets/logo_3_dark.png';
  } else {
    bg = 'assets/logo_3_cb.png';
  }
  return Drawer(
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.16,
              child: Image.asset(bg)),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Theme.of(context).textTheme.headline3!.color!,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.home),
              title: Text(S.of(context).navbar_home),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Theme.of(context).textTheme.headline3!.color!,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.person_sharp),
              title: Text(S.of(context).navbar_profile),
              onTap: () {
                Navigator.popAndPushNamed(context, '/profile');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Theme.of(context).textTheme.headline3!.color!,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text(S.of(context).navbar_history),
              onTap: () {
                Navigator.popAndPushNamed(context, '/history');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Theme.of(context).textTheme.headline3!.color!,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).navbar_settings),
              onTap: () {
                Navigator.popAndPushNamed(context, '/settings');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text(S.of(context).collect_data),
              onTap: () {
                Navigator.popAndPushNamed(context, '/capture');
              }),
        ),
      ],
    ),
  );
}
