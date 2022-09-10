import 'package:flutter/material.dart';
import 'package:fluttertest/home_screen.dart';

import 'login_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
      return MaterialApp(
        home:LoginScreen(),
      );
  }
}