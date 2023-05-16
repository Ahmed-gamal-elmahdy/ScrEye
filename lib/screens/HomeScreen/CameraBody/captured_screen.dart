import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'capturedCubit/captured_cubit.dart';

class CapturedScreen extends StatelessWidget {
  final CapturedCubit capturedCubit;
  final String? imagePath;

  CapturedScreen({required this.capturedCubit, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    capturedCubit.updateImage(imagePath!); // Update the image path in the state
    return BlocProvider.value(
      value: capturedCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Captured Screen'),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<CapturedCubit, CapturedState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (name) {
                        capturedCubit.updateName(name);
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (age) {
                        capturedCubit.updateAge(int.parse(age));
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: 'male',
                          groupValue: state.gender,
                          onChanged: (value) {
                            capturedCubit.updateGender(value);
                          },
                        ),
                        Text('Male'),
                        SizedBox(width: 20),
                        Radio(
                          value: 'female',
                          groupValue: state.gender,
                          onChanged: (value) {
                            capturedCubit.updateGender(value);
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (additionalInfo) {
                        capturedCubit.updateAdditionalInfo(additionalInfo);
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Additional Info',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        capturedCubit.saveCaptured();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
