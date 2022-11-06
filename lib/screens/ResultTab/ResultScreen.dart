
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertest/screens/CameraTab/CameraScreen.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';



class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://phito.be/wp-content/uploads/2020/01/placeholder.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
      child: Center(
        child: Container(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Upload a Saved Image",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w300,

              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(label: Text('Upload'), icon:Icon(Icons.upload), onPressed: () async {
              final _firebaseStorage = FirebaseStorage.instance;
              final _imagePicker = ImagePicker();
              PickedFile image;
              image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
              print('LOOK!');
              print(image);
              pickImage(image).then((value) => print(value));
            },),
          ],
        )
        ),
      ),

    )
    );
  }
}

Future<String> pickImage(image) async {
  final _firebaseStorage = FirebaseStorage.instance;

  if (image != null){
    //Upload to Firebase
    var file = File(image.path);
    var snapshot = await _firebaseStorage.ref()
        .child('images/imageName')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
  return "false";

}

