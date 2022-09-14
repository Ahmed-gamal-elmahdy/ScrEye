import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import "package:firebase_auth/firebase_auth.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,
  required this.user,}) : super(key: key);


  final User user;
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  print(user);
                  FlutterFireUIAuth.signOut(
                    context: context,
                    auth: SignOutButton().auth,
                  );
                },
                icon: Icon(Icons.door_back_door_outlined)),
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

