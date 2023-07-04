import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import 'capturedCubit/captured_cubit.dart';

class CollectionCapturedScreen extends StatelessWidget {
  final CapturedCubit capturedCubit;
  final String? imagePath;

  CollectionCapturedScreen(
      {required this.capturedCubit, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    capturedCubit.updateImage(imagePath!); // Update the image path in the state
    return BlocProvider.value(
      value: capturedCubit,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                          labelText: S.of(context).name,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (age) {
                          capturedCubit.updateAge(int.parse(age));
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: S.of(context).age,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Gender',style: TextStyle(fontSize: 17),),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio(
                            value: 'Male',
                            groupValue: state.gender,
                            onChanged: (value) {
                              capturedCubit.updateGender(value);
                            },
                          ),
                          Text(S.of(context).male),
                          const SizedBox(width: 20),
                          Radio(
                            value: 'Female',
                            groupValue: state.gender,
                            onChanged: (value) {
                              capturedCubit.updateGender(value);
                            },
                          ),
                          Text(S.of(context).female),
                          const SizedBox(width: 20),
                          Radio(value: null, groupValue: null, onChanged: (Null? value) { },
                            activeColor: Theme.of(context).textTheme.headline3!.color!,
                          ),
                          Text("empty",style: TextStyle(color: Theme.of(context).textTheme.headline3!.color!),),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Case', style: TextStyle(fontSize: 17)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                            value: 'Anemic',
                            groupValue: state.anemic,
                            onChanged: (value) {
                              capturedCubit.updateAnemic(value);
                            },
                          ),
                          Text(S.of(context).anemic),
                          const SizedBox(width: 10),
                          Radio(
                            value: 'Non Anemic',
                            groupValue: state.anemic,
                            onChanged: (value) {
                              capturedCubit.updateAnemic(value);
                            },
                          ),
                          Text(S.of(context).not_anemic),
                          const SizedBox(width: 10),
                          Radio(
                            value: '',
                            groupValue: state.anemic,
                            onChanged: (value) {
                              capturedCubit.updateAnemic(value);
                            },
                          ),
                          Text('N/A'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (additionalInfo) {
                          capturedCubit.updateAdditionalInfo(additionalInfo);
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: S.of(context).additional_info,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          capturedCubit.chooseFiles();
                        },
                        child: Text(S.of(context).choose_files),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          capturedCubit.saveCaptured();
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).save),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
