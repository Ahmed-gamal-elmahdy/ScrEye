import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../generated/l10n.dart';
import '../../widgets/Debouncer.dart';
import '../../widgets/MyDrawer.dart';
import 'ProfileCubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit _cubit = ProfileCubit();
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: "Logout",
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
        title: Text(S.of(context).profile),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: S.of(context).name, hintText: state.name),
                      onChanged: (value) => {_cubit.updateName(value)},
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: S.of(context).emailInputLabel,
                          hintText: state.email),
                      onChanged: (value) => _cubit.updateEmail(value),
                    ),
                    SizedBox(height: 16.0),
                    /*
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: S.of(context).passwordInputLabel,
                          suffixIcon: IconButton(
                              onPressed: () {
                                _cubit.updateVisibility(!state.visibility);
                              },
                              icon: Icon(state.visibility
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded))),
                      obscureText: state.visibility,
                      onChanged: (value) => _cubit.updatePassword(value),
                    ),
                    SizedBox(height: 16.0),

                     */
                    TextField(
                      keyboardType: TextInputType.number,
                      // show numeric keyboard
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                        // only allow digits
                      ],
                      decoration: InputDecoration(
                          labelText: S.of(context).age,
                          hintText: state.age.toString()),
                      onChanged: (value) => _cubit.updateAge(int.parse(value)),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: state.gender,
                          onChanged: (value) =>
                              _cubit.updateGender(value ?? ''),
                        ),
                        Text(S.of(context).male),
                        Radio<String>(
                          value: 'Female',
                          groupValue: state.gender,
                          onChanged: (value) =>
                              _cubit.updateGender(value ?? ''),
                        ),
                        Text(S.of(context).female),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    OutlinedButton(
                      onPressed: () => {_cubit.askConfirmation(context)},
                      style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.backgroundColor,
                      ),
                      child: Text(S.of(context).update_profile),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileLoading) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.threeArchedCircle(
                    color: Theme.of(context).textTheme.headline5!.color!,
                    size: 50),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  S.of(context).pls_wait,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.subtitle1!.color!,
                  ),
                ),
              ],
            ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
