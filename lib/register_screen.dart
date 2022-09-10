import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

FirebaseAuth auth = FirebaseAuth.instance;

register(email, password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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

class _RegisterScreen extends State<RegisterScreen> {
  var passwordcontrol = TextEditingController();

  var emailcontrol = TextEditingController();
  bool ishidden = true;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Text(
              "Register",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: emailcontrol,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email_rounded),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime),
                    borderRadius: BorderRadius.circular(20),
                  )),
              // style: TextStyle(fontSize:15),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: passwordcontrol,
              keyboardType: TextInputType.text,
              obscureText: ishidden,
              decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.key_rounded),
                  suffixIcon: IconButton(
                      onPressed: () {
                        ishidden = !ishidden;
                        setState(() {});
                      },
                      icon: Icon(Icons.remove_red_eye_rounded)
                  ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lime),
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
            SizedBox(height: 15
            ),
            MaterialButton(child:Text("Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
              onPressed: (){
              register(emailcontrol.value, passwordcontrol.value);},
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
