import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/mySnackBar.dart';

import '../../generated/l10n.dart';

final TextEditingController _emailController = TextEditingController();

Future<void> showPasswordResetDialog(BuildContext context,TextDirection textDirection) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: textDirection,
        child: AlertDialog(
          title: Text(S.of(context).resetPasswordButtonLabel),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).email_password_title),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: S.of(context).emailInputLabel),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).emailIsRequiredErrorText;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).discard),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () async {
                if (_emailController.text.isEmpty) {
                  showSnackBar(context, S.of(context).emailIsRequiredErrorText, SnackBarType.error);
                  return;
                }
                else if(!EmailValidator.validate(_emailController.text)){
                  showSnackBar(context, S.of(context).isNotAValidEmailErrorText, SnackBarType.error);
                  return;
                }
                else{
                  await resetPassword(context,_emailController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
Future<void> resetPassword(context,String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showSnackBar(context, S.of(context).success_reset_password, SnackBarType.success);
  } catch (e) {
    showSnackBar(context, S.of(context).failed_reset_password, SnackBarType.error);
    rethrow;
  }
}