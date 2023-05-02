import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';

import '../../../generated/l10n.dart';
import '../../widgets/Language.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          drawer: myDrawer(context),
          appBar: AppBar(
            actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    FirebaseUIAuth.signOut();
                  },
                  icon: Icon(Icons.power_settings_new_rounded))
            ],
            title: Text(S.of(context).navbar_settings),
          ),
          body: Directionality(
            textDirection: cubit.layoutDirection ?? TextDirection.ltr,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(S.of(context).language + ":"),
                      DropdownButton<Language>(
                        hint: Text(S.of(context).lang),
                        value: cubit.selectedLanguage,
                        onChanged: (Language? value) {
                          cubit.languageChanged(newLang: value);
                        },
                        items: cubit.languages.map((language) {
                          return DropdownMenuItem<Language>(
                            value: language,
                            // Use a unique identifier as the value
                            child: Row(
                              children: [
                                Flag.fromString(language.code,
                                    height: 25.h, width: 50.w),
                                SizedBox(width: 8.w),
                                Text(language.name),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
