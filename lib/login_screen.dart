import 'dart:ui';

import 'package:flutter/material.dart';




class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var passwordcontrol= TextEditingController();

  var emailcontrol= TextEditingController();
  bool ishidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailcontrol,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    hintText: "Write your email",
                    prefixIcon: Icon(Icons.email_rounded),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lime),
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                 // style: TextStyle(fontSize:15),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordcontrol,
                  keyboardType: TextInputType.text,
                  obscureText: ishidden,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Write your Password",
                      prefixIcon: Icon(Icons.key_rounded),
                      suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        print(ishidden);
                        ishidden = !ishidden;
                      });
                      }, icon: Icon(Icons.remove_red_eye_rounded)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lime),
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                  // style: TextStyle(fontSize:15),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      child: ElevatedButton(onPressed: (){
                        print(emailcontrol.text);
                        print(passwordcontrol.text);
                      },child: Text("Sign in",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      )
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"
                    ),
                   TextButton(onPressed: (){}, child: Text("Register",
                     style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
