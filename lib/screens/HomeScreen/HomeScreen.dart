import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';

import '../../generated/l10n.dart';
import '../../widgets/MyDrawer.dart';
import 'CameraBody/CameraScreen.dart';
import 'ResultBody/ResultScreen.dart';
import 'UploadBody/UploadScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.user,
    required AppCubit appCubit,
  }) : super(key: key);

  final User user;

  void _initiateCameraAndUser(AppCubit cubit) {
    cubit.user = user;
    if (!cubit.cameraInitiated) {
      cubit.startCamera();
    }
  }

  Widget _buildBodyScreen(AppCubit cubit) {
    switch (cubit.bodyIndex) {
      case 0:
        return const UploadScreen();
      case 1:
        return CameraScreen();
      case 2:
        return const ResultScreen();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, AppCubit cubit) {
    return BottomNavigationBar(
      currentIndex: cubit.bodyIndex,
      onTap: (index) => cubit.ChangeBodyIndex(index),
      items: [
        BottomNavigationBarItem(
            label: S.of(context).upload, icon: const Icon(Icons.upload)),
        BottomNavigationBarItem(
            label: S.of(context).camera,
            icon: const Icon(Icons.camera_alt_outlined)),
        BottomNavigationBarItem(
            label: S.of(context).result,
            icon: const Icon(Icons.insert_drive_file_outlined)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List bodyNames = [
      S.of(context).upload,
      S.of(context).align_clipper,
      S.of(context).result,
    ];
    return BlocProvider.value(
      value: AppCubit.get(context),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          _initiateCameraAndUser(cubit);
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
              title: Text(bodyNames[cubit.bodyIndex]),
            ),
            body: _buildBodyScreen(cubit),
            bottomNavigationBar: _buildBottomNavigationBar(context, cubit),
          );
        },
      ),
    );
  }
}
