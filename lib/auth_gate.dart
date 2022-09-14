import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return
            MaterialApp(
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

              ),
              home: Center(
                child: SignInScreen(
                    resizeToAvoidBottomInset:true,
                providerConfigs: const [
                  EmailProviderConfiguration(),
                ],
                headerBuilder: (context,constrains,_){
                  return CircleAvatar(
                    radius: 25,
                  );
                },
                  footerBuilder: (context,Action){
                  return Text("Testastastt");
                  },

          ),
              ),
            );
        }
        return HomeScreen(user: snapshot.data!);
      },
    );
  }
}