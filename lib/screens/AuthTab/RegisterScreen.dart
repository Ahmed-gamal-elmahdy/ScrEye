import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  bool isVisible=false;
  Future<void> _register() async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Map<String,String?> user={
        //'name':state.credential.user?.displayName,
        'name':"",
        "age":"",
        'gender':"Male",
        'email': userCredential.user?.email,
        'uid': userCredential.user?.uid,
        //'phoneNumber':state.credential.user?.phoneNumber
      };
      if(userCredential.user?.uid != null)
      {
        var uid= userCredential.user?.uid;
        _dbRef.child(uid!).set(user);
      }
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
                SizedBox(height:30.h),
                Container(
                  color: Colors.red,
                  height: 150.h,
                ),
                SizedBox(height:30.h),
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
                SizedBox(height:16.h),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password',suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isVisible= isVisible? false:true;
                    });
                  }, icon: Icon(isVisible? Icons.visibility_rounded:Icons.visibility_off_rounded))),
                  obscureText: !isVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height:16.h),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ){
                      return 'Please rewrite your password';
                    }
                    else if(
                    value != _passwordController.text
                    )
                      {
                        return 'Password mismatch';
                      }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
                  },
                  child: Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  child: Text('login'),
                ),
                Container(
                  color: Colors.red.withOpacity(0.3),
                  height: 150.h,
                ),
                SizedBox(height:30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
