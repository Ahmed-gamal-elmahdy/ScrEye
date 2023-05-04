import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/HistoryTab/HistoryTab.dart';
import 'package:fluttertest/screens/ProfileTab/ProfileTab.dart';
import 'package:fluttertest/screens/SettingsTab/SettingsTab.dart';
import 'package:fluttertest/screens/home_screen.dart';
import 'package:fluttertest/screens/myAuthGate.dart';

import 'cubit/AppSettingsCubit/app_settings_cubit.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  final AppSettingsCubit? appSettingsCubit;

  const MyApp({Key? key, this.appSettingsCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appSettingsCubit == null
        ? BlocProvider<AppSettingsCubit>(
            create: (context) => AppSettingsCubit(),
            child: _buildApp(context),
          )
        : BlocProvider.value(
            value: appSettingsCubit!,
            child: _buildApp(context),
          );
  }

  Widget _buildApp(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading screen while waiting for the auth state to change
                  return const CircularProgressIndicator();
                } else {
                  // Check if the user is logged in
                  if (snapshot.hasData) {
                    // If the user is logged in, navigate to the HomePage and pass the snapshot data as a parameter
                    return ScreenUtilInit(
                        designSize: const Size(360, 690),
                        minTextAdapt: true,
                        splitScreenMode: true,
                        builder: (BuildContext context, Widget? child) {
                          return MaterialApp(
                            localizationsDelegates: const [
                              S.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                            ],
                            supportedLocales: S.delegate.supportedLocales,
                            locale: state.locale,
                            theme: state.theme,
                            debugShowCheckedModeBanner: false,
                            initialRoute: '/',
                            routes: {
                              '/': (context) =>
                                  HomeScreen(user: snapshot.data!),
                              '/profile': (context) => ProfileTab(),
                              '/history': (context) => HistoryTab(),
                              '/settings': (context) => SettingsTab(),
                            },
                            builder: (context, child) {
                              return Directionality(
                                textDirection: state.directionality,
                                child: child!,
                              );
                            },
                          );
                        });
                  } else {
                    // If the user is not logged in, navigate to the AuthGate screen
                    return const myAuthGate();
                  }
                }
              },
            );
          },
        );
      },
    );
  }
}
