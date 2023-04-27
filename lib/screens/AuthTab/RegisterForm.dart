
import 'package:flag/flag.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/AuthTab/authenticationCubit/authentication_cubit.dart';

import '../../../generated/l10n.dart';
class RegistrationForm extends StatelessWidget {
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.asset('assets/logo_2.png')),
                    ),
                  ),
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (context, state) {
                      if (state is RegistrationLoading) {
                        return CircularProgressIndicator();
                      } else if (state is AuthenticationFailure) {
                        return Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.red),
                        );
                      } else if (state is RegistrationSuccess) {
                        return Text(
                          'Registration successful!',
                          style: TextStyle(color: Colors.green),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                          DropdownButton<Language>(
                            hint: Text(S.of(context).lang),
                            value: authenticationCubit.selectedLanguage,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFFF05454),
                            ),
                            onChanged: (Language? newValue) {
                              authenticationCubit.languageChanged(newValue);
                            },
                            items: authenticationCubit.languages.map((Language lang) {
                              return DropdownMenuItem<Language>(
                                value: lang,
                                child: Row(
                                  children: [
                                   Flag.fromString(lang.code,height: 25.h, width: 50.w,),
                                    SizedBox(width: 8.w),
                                    Text(lang.lang),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        Text(S.of(context).registerButtonText, style: TextStyle(fontSize: 30.sp)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: S.of(context).emailInputLabel,
                      ),
                      onChanged: (value) {
                        authenticationCubit.emailChangedRegister(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: S.of(context).passwordInputLabel,
                          suffixIcon: IconButton(
                              onPressed: () {
                                authenticationCubit.visibilityChanged();
                              },
                              icon: Icon(authenticationCubit.isVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded))),
                      obscureText: !authenticationCubit.isVisible,
                      onChanged: (value) {
                        authenticationCubit.passwordChangedRegister(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: S.of(context).confirmPasswordInputLabel,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        authenticationCubit
                            .passwordConfirmChangedRegister(value);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                      child: RichText(
                        text: TextSpan(
                          text: S.of(context).already_user,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3177A3)),
                          children: [
                            TextSpan(
                              text: S.of(context).signInText,
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
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: OutlinedButton(
                      onPressed: () {
                        authenticationCubit.submitRegistration(context);
                      },
                      child: Text(S.of(context).registerText),
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
