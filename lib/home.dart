import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(onPressed: (){
              onPressed: () => FlutterFireUIAuth.signOut(
                context: context,
                auth: SignOutButton().auth,
              );
            }, icon: Icon(Icons.door_back_door_outlined)),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SignOutButton(),
          ],
        ),
      ),
    );
  }
}