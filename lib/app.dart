import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/auth_gate.dart';

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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              foregroundColor: Color(0xFF90CBF0),
              backgroundColor: Color(0xFF3177A3),
              iconTheme: IconThemeData(
                color: Color(0xFFF05454),
              ),
              elevation: 0,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF3177A3),
              unselectedItemColor: Color(0xFF90CBF0),
              selectedItemColor: Color(0xFFF05454),
            ),
              canvasColor: Color(0xFF90CBF0),
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
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF90CBF0)),
                side: MaterialStateProperty.all(BorderSide(
                  color: Color(0xFF225270),
                )),
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color(0xFF225270),
            ),
            scaffoldBackgroundColor: const Color(0xFF90CBF0),
          ),

          home: child,
        );
      },
      child: const AuthGate(),
    );
  }
}