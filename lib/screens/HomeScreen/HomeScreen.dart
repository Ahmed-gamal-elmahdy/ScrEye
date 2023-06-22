import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/screens/HomeScreen/CameraBody/CameraScreen.dart';

import '../../generated/l10n.dart';
import '../../widgets/MyDrawer.dart';
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
    return ConvexAppBar(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      curveSize: 75,
      top: -20,
      items: [
        TabItem(
          title: S.of(context).upload,
          icon: Icon(
            Icons.upload,
            color:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          ),
          activeIcon: Icon(
            Icons.upload,
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          ),
        ),
        TabItem(
          title: S.of(context).camera,
          icon: Icon(
            Icons.camera_alt_outlined,
            color: Theme.of(context).textTheme.headline1!.color!,
          ),
        ),
        TabItem(
          title: S.of(context).result,
          icon: Icon(
            Icons.insert_drive_file_outlined,
            color:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          ),
          activeIcon: Icon(
            Icons.insert_drive_file_outlined,
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          ),
        ),
      ],
      initialActiveIndex: cubit.bodyIndex,
      onTap: (index) => cubit.ChangeBodyIndex(index),
      style: TabStyle.fixedCircle,
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
