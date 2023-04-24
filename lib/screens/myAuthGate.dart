import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'AuthTab/LogInScreen.dart';
import 'AuthTab/RegisterScreen.dart';
import 'home_screen.dart';


var dbRef = FirebaseDatabase.instance.ref().child('users');
class myAuthGate extends StatelessWidget {
  const myAuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    //const providers = [EmailAuthProvider()];
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/register'
                : '/sign-in',
            routes: {
              '/register': (context) => RegistrationScreen(),
              '/sign-in': (context) => LoginScreen()
            },
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color(0xFF3177A3),
                displayColor: Color(0xFF3177A3),
              ),
              canvasColor: Color(0xFF90CBF0),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFF05454), // Text Color
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF3177A3)),
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color(0xFF3177A3),
                  )),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                focusColor: Color(0xFFF05454),
                labelStyle: TextStyle(color: const Color(0xFF3177A3)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color(0xFF3177A3)),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Color(0xFFF05454), width: 0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: const Center(),
          );
        }
        return HomeScreen(user: snapshot.data!);
      },
    );
  }
}

