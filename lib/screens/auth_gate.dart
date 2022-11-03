import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'home_screen.dart';

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
                  return Container(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Anemia detector',
                          style: TextStyle(fontSize:30,color: Colors.red),
                        ),

                      ],
                    ),
                  );
                },
                  footerBuilder: (context,Action){
                  return Container(
                      child: Text("Testastastt")
                  );
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