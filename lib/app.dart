
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/myAuthGate.dart';
import 'generated/l10n.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MaterialApp(
          localizationsDelegates: [
            // Creates an instance of FirebaseUILocalizationDelegate with overridden labels
            // Delegates below take care of built-in flutter widgets
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // This delegate is required to provide the labels that are not overridden by LabelOverrides
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF3177A3),
              iconTheme: IconThemeData(
                color: Color(0xFFF05454),
              ),
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF3177A3),
              unselectedItemColor: Colors.white,
              selectedItemColor: Color(0xFFF05454),
            ),
              canvasColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF225270), // Text Color
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                foregroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF225270)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all(BorderSide(
                  color: Color(0xFF225270),
                )),
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color(0xFF225270),
            ),
          ),

          home: child,
        );
      },
      child: const myAuthGate(),
    );
  }
}