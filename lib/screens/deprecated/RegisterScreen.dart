import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _dbRef = FirebaseDatabase.instance.ref().child('users');
  bool isVisible = false;

  Future<void> _register() async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ).then((user) {
        Map<String, String?> myuser = {
          //'name':state.credential.user?.displayName,
          'name': "",
          "age": "",
          'gender': "Male",
          'email': user.user?.email,
          'uid': user.user?.uid,
          //'phoneNumber':state.credential.user?.phoneNumber
        };
        if (user.user?.uid != null) {
          var uid = user.user?.uid;
          _dbRef.child(uid!).set(myuser);
        }
        // The user is authenticated, so navigate to the home screen.
      });


      // Navigate to the home screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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

                    Text("Register",style: TextStyle(
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
                      return 'email not valid';
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
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please rewrite your password';
                    } else if (value != _passwordController.text) {
                      return 'Password mismatch';
                    }
                    return null;
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: RichText(
                      text: TextSpan(
                        text: "Already a ScrEye user?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3177A3)),
                        children: [
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF05454),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .popAndPushNamed('/login');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register().then((value) => null);
                    }
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
