import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/app.dart';

import '../generated/l10n.dart';
import '../themes/MyTheme.dart';
import 'AuthScreen/LoginForm.dart';
import 'AuthScreen/RegisterForm.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (!snapshot.hasData) {
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                initialRoute: FirebaseAuth.instance.currentUser == null
                    ? '/register'
                    : '/login',
                routes: {
                  '/register': (context) => RegistrationForm(),
                  '/login': (context) => LoginForm(),
                },
                theme: MyTheme.whiteTheme(),
              );
            } else {
              return const MyApp();
            }
          },
        );
      },
    );
  }
}
