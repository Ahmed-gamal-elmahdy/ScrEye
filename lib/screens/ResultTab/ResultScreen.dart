import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertest/screens/CameraTab/CameraScreen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        if (state is TestDone) {
          return Center(
              child: Text(
            cubit.test_result,
            style: TextStyle(fontSize: 50),
          ));
        }
        if (state is WaitingResult) {
          return Center(
              child: Text(
            "Please wait",
            style: TextStyle(fontSize: 50),
          ));
        } else {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://phito.be/wp-content/uploads/2020/01/placeholder.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Center(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload img",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton.icon(
                    label: Text('Upload'),
                    icon: Icon(Icons.upload),
                    onPressed: () async {
                      final _imagePicker = ImagePicker();
                      var image = (await _imagePicker.pickImage(
                          source: ImageSource.gallery))!;
                      cubit.uploadImage(image).then((value) {
                        cubit.testGet(imgname: value[0], token: value[1]);
                      });
                    },
                  ),
                ],
              )),
            ),
          );
        }
      },
    );
  }
}
