import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'capturedCubit/captured_cubit.dart';

class CollectionCapturedScreen extends StatelessWidget {
  final CapturedCubit capturedCubit;
  final String? imagePath;

  CollectionCapturedScreen({required this.capturedCubit, required this.imagePath});

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
                    const SizedBox(height: 20),

                    TextField(
                      onChanged: (name) {
                        capturedCubit.updateName(name);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (age) {
                        capturedCubit.updateAge(int.parse(age));
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: state.gender,
                          onChanged: (value) {
                            capturedCubit.updateGender(value);
                          },
                        ),
                        const Text('Male'),
                        const SizedBox(width: 20),
                        Radio(
                          value: 'Female',
                          groupValue: state.gender,
                          onChanged: (value) {
                            capturedCubit.updateGender(value);
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Radio(
                          value: 'Anemic',
                          groupValue: state.anemic,
                          onChanged: (value) {
                            capturedCubit.updateAnemic(value);
                          },
                        ),
                        const Text('Anemic'),
                        const SizedBox(width: 10),
                        Radio(
                          value: 'Non Anemic',
                          groupValue: state.anemic,
                          onChanged: (value) {
                            capturedCubit.updateAnemic(value);
                          },
                        ),
                        const Text('Non Anemic'),
                        const SizedBox(width: 10),
                        Radio(
                          value: '',
                          groupValue: state.anemic,
                          onChanged: (value) {
                            capturedCubit.updateAnemic(value);
                          },
                        ),
                        const Text('Not sure'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (additionalInfo) {
                        capturedCubit.updateAdditionalInfo(additionalInfo);
                      },
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Additional Info',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        capturedCubit.chooseFiles();
                      },
                      child: Text('Upload Files'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        //capturedCubit.saveCaptured();//user firestore
                        capturedCubit.saveCapturedRealtimeDB();//uses realtime
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
