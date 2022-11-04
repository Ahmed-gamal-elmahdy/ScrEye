
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';



class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(child: IconButton(icon: Icon(Icons.ac_unit_rounded),onPressed: () async {
      final _firebaseStorage = FirebaseStorage.instance;
      final _imagePicker = ImagePicker();
      PickedFile image;
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      uploadImage(image).then((value) => print(value));

    },),
    
    );
  }
}

Future<String> uploadImage(image) async {
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

