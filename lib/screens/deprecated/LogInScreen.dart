import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isVisible = false;
  Future<void> _login() async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to the home screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/logo_2.png')),
                  ),
                ),
              Row(
              children: [
              Text("Sign In",style: TextStyle(
              fontSize: 35.sp
          )),
          ],
        ),
          SizedBox(
            height: 10.h,
          ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Email not valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = isVisible ? false : true;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded))),
                  obscureText: !isVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Reset Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF05454),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //TODO forgot password
                                    // Navigator.of(context).popAndPushNamed('/forgot-password');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Text('Sign In'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: RichText(
                          text: TextSpan(
                            text: "New to ScrEye?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3177A3)),
                            children: [
                              TextSpan(
                                text: ' Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF05454),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .popAndPushNamed('/register');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
