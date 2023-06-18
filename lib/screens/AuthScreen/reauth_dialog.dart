import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          SizedBox(height: 16),
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
          child: _isLoading
              ? Container(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Color(0xFFF05454), size: 20))
              : Text(S.of(context).auth),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).authError),
                        backgroundColor: Color(0xFFCE772F),
                      ),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
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
