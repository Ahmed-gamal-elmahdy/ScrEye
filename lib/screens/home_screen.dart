
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/screens/CameraTab/CameraScreen.dart';
import 'package:fluttertest/screens/HomeTab/HomeTab.dart';
import 'package:fluttertest/screens/ResultTab/ResultScreen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List tabNames = [
            "Home",
            "Align Clipper with Conjunctiva",
            "Results",
          ];
          List tabScreens = [
           HomeTab(),
            CameraScreen(),
            ResultScreen()
          ];
          var cubit = AppCubit.get(context);
          if(!cubit.cameraInitiated){
            cubit.startCamera();
            cubit.user=user;
          }
          return Scaffold(
            appBar: AppBar(actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    FirebaseUIAuth.signOut();
                  },
                  icon: Icon(Icons.power_settings_new_rounded))
            ], title: Text(tabNames[cubit.tabIndex])),
            body: tabScreens[cubit.tabIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.tabIndex,
              items: [
                BottomNavigationBarItem(

                    label: "Home",
                    icon: IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          cubit.ChangeTabIndex(0);
                        })),
                BottomNavigationBarItem(
                    label: "Camera",
                    icon: IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: () {
                          cubit.ChangeTabIndex(1);
                        })),
                BottomNavigationBarItem(
                    label: "Result",
                    icon: IconButton(
                        icon: Icon(Icons.insert_drive_file_outlined),
                        onPressed: () {
                          cubit.ChangeTabIndex(2);
                        }))
              ],
            ),
          );
        },
      ),
    );
  }
}
