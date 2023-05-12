import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                FirebaseUIAuth.signOut();
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
                    DropdownButton<int>(
                      value: state.age,
                      hint: Text(S.of(context).age),
                      onChanged: (value) => _cubit.updateAge(value ?? 0),
                      items: List.generate(
                        70,
                        (index) => DropdownMenuItem(
                          value: index,
                          child: Text('$index'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
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
                    ElevatedButton(
                      onPressed: () => {_cubit.askConfirmation(context)},
                      child: Text(S.of(context).save),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileLoading) {
            return LoadingIndicator(size: 10, borderWidth: 3);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
