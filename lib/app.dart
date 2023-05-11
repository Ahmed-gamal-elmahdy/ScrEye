import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/AuthGate.dart';
import 'package:fluttertest/screens/HistoryScreen/HistoryScreen.dart';
import 'package:fluttertest/screens/HomeScreen/HomeScreen.dart';
import 'package:fluttertest/screens/ProfileScreen/ProfileScreen.dart';
import 'package:fluttertest/screens/SettingsScreen/SettingsScreen.dart';

import 'cubit/AppSettingsCubit/app_settings_cubit.dart';
import 'cubit/app_cubit.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  final AppSettingsCubit? appSettingsCubit;
  final AppCubit? appCubit;

  const MyApp({Key? key, this.appSettingsCubit, this.appCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        appSettingsCubit == null
            ? BlocProvider<AppSettingsCubit>(
                create: (context) => AppSettingsCubit())
            : BlocProvider.value(value: appSettingsCubit!),
        appCubit == null
            ? BlocProvider<AppCubit>(create: (context) => AppCubit())
            : BlocProvider.value(value: appCubit!),
      ],
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
                              GlobalCupertinoLocalizations.delegate,
                            ],
                            supportedLocales: S.delegate.supportedLocales,
                            locale: state.locale,
                            theme: state.theme,
                            debugShowCheckedModeBanner: false,
                            initialRoute: '/',
                            routes: {
                              '/': (context) => HomeScreen(
                                  user: snapshot.data!,
                                  appCubit: context.read<AppCubit>()),
                              '/profile': (context) => ProfileScreen(),
                              '/history': (context) => const HistoryScreen(),
                              '/settings': (context) => const SettingsScreen(),
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
                    return const AuthGate();
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
