import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, SnackBarType type) {
  final snackBar = SnackBar(
    backgroundColor:
        type == SnackBarType.success ? Colors.green : Colors.orange,
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

enum SnackBarType {
  success,
  error,
}
