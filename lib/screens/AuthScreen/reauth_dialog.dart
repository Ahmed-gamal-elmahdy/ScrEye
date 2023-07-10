import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/mySnackBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../generated/l10n.dart';

class ReauthenticationDialog extends StatefulWidget {
  final String message;

  ReauthenticationDialog({required this.message});

  @override
  _ReauthenticationDialogState createState() => _ReauthenticationDialogState();
}

class _ReauthenticationDialogState extends State<ReauthenticationDialog> {
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).listTileTheme.tileColor,
      title: Text(S.of(context).confirm_settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.message),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: S.of(context).confirmPasswordInputLabel,
              hintStyle: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).discard),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        OutlinedButton(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  final user = FirebaseAuth.instance.currentUser;
                  final credential = EmailAuthProvider.credential(
                    email: user!.email!,
                    password: _passwordController.text,
                  );
                  try {
                    await user.reauthenticateWithCredential(credential);
                    Navigator.of(context).pop(true);
                  } on FirebaseAuthException catch (e) {
                    showSnackBar(
                        context, S.of(context).authError, SnackBarType.error);
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
          child: _isLoading
              ? Container(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Theme.of(context).textTheme.subtitle2!.color!,
                      size: 20))
              : Text(S.of(context).auth),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
