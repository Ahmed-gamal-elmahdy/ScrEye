import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';

import '../../../generated/l10n.dart';
import '../../widgets/MyDrawer.dart';
import 'CameraBody/CameraScreen.dart';
import 'ResultBody/ResultScreen.dart';
import 'UploadBody/UploadScreen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List bodyNames = [
          S.of(context).upload,
          S.of(context).align_clipper,
          S.of(context).result,
        ];
        List bodyScreens = [ UploadScreen(), CameraScreen(), const ResultScreen()];
        return Scaffold(
          drawer: myDrawer(context, cubit),
          appBar:AppBar(
            actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    FirebaseUIAuth.signOut();
                  },
                  icon: const Icon(Icons.power_settings_new_rounded))
            ],
            title: Text(bodyNames[cubit.bodyIndex]),
          ),
          body: bodyScreens[cubit.bodyIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bodyIndex,
            items: [
              BottomNavigationBarItem(
                  label: S.of(context).upload,
                  icon: IconButton(
                      icon: const Icon(Icons.upload),
                      onPressed: () {
                        cubit.ChangeBodyIndex(0);
                      })),
              BottomNavigationBarItem(
                  label: S.of(context).camera,
                  icon: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        cubit.ChangeBodyIndex(1);
                      })),
              BottomNavigationBarItem(
                  label: S.of(context).result,
                  icon: IconButton(
                      icon: const Icon(Icons.insert_drive_file_outlined),
                      onPressed: () {
                        cubit.ChangeBodyIndex(2);
                      }))
            ],
          ),
        );
      },
    );
  }
}
