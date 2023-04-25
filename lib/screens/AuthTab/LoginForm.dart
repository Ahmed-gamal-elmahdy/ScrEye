import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/AuthTab/authenticationCubit/authentication_cubit.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Builder(
        builder: (context) {
          final authenticationCubit = context.watch<AuthenticationCubit>();
          return Scaffold(
            body: SingleChildScrollView(
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
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return CircularProgressIndicator();
                      } else if (state is AuthenticationFailure) {
                        return Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.red),
                        );
                      } else if (state is LoginSuccess) {
                        return Text(
                          'Login successful!',
                          style: TextStyle(color: Colors.green),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        Text("Login", style: TextStyle(fontSize: 30.sp)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        authenticationCubit.emailChangedLogin(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                authenticationCubit.visibilityChanged();
                              },
                              icon: Icon(authenticationCubit.isVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded))),
                      obscureText: !authenticationCubit.isVisible,
                      onChanged: (value) {
                        authenticationCubit.passwordChangedLogin(value);
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 5.h),
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.w),
                    child: ElevatedButton(
                      onPressed: () {
                        authenticationCubit.submitLogin();
                      },
                      child: const Text('Login'),
                    ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
