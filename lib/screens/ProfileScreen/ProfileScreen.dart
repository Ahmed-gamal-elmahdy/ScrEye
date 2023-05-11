import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ProfileCubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit _cubit = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) => _cubit.updateName(value),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (value) => _cubit.updateEmail(value),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) => _cubit.updatePassword(value),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButton<int>(
                    value: state.age,
                    hint: Text('Age'),
                    onChanged: (value) => _cubit.updateAge(value ?? 0),
                    items: List.generate(
                      121,
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
                        onChanged: (value) => _cubit.updateGender(value ?? ''),
                      ),
                      Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: state.gender,
                        onChanged: (value) => _cubit.updateGender(value ?? ''),
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () => _cubit.saveChanges(context),
                    child: Text('Save Changes'),
                  ),
                ],
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
