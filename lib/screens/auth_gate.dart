import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'home_screen.dart';


var dbRef = FirebaseDatabase.instance.ref().child('users');
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    //const providers = [EmailAuthProvider()];
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/register'
                : '/sign-in',
            routes: {
              '/register': (context) => RegisterScreen(
                actions: [
                  AuthStateChangeAction<UserCreated>((context, state) {
                    Map<String,String?> user={
                      //'name':state.credential.user?.displayName,
                      'name':"",
                      "age":"",
                      'gender':"Male",
                      'email':state.credential.user?.email,
                      'uid':state.credential.user?.uid,
                      //'phoneNumber':state.credential.user?.phoneNumber
                    };
                    if(state.credential.user?.uid != null)
                      {

                        var uid= state.credential.user?.uid;
                        dbRef.child(uid!).set(user);
                      }


                  }),
                ],
                showAuthActionSwitch: false,
                resizeToAvoidBottomInset: true,
                //providers: providers,
                headerBuilder: (context, constrains, _) {
                  return Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.1),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/logo_2.png')),
                  );
                },
                footerBuilder: (context, constrains) {
                  return Padding(
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
                                    .popAndPushNamed('/sign-in');
                              },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              '/sign-in': (context) {
                return SignInScreen(
                  showAuthActionSwitch: false,
                  resizeToAvoidBottomInset: true,
                  //providers: providers,
                  headerBuilder: (context, constrains, _) {
                    return Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('assets/logo_2.png')),
                    );
                  },
                  footerBuilder: (context, constrains) {
                    return Padding(
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
                    );
                  },

                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      Navigator.pushReplacementNamed(context, '/profile');
                    }),
                  ],
                );
              },
            },
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color(0xFF3177A3),
                displayColor: Color(0xFF3177A3),
              ),
              canvasColor: Color(0xFF90CBF0),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFFF05454), // Text Color
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF3177A3)),
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color(0xFF3177A3),
                  )),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                focusColor: Color(0xFFF05454),
                labelStyle: TextStyle(color: const Color(0xFF3177A3)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color(0xFF3177A3)),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Color(0xFFF05454), width: 0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: const Center(),
          );
        }
        return HomeScreen(user: snapshot.data!);
      },
    );
  }
}

