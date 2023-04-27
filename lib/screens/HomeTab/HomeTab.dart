import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:sidebarx/sidebarx.dart';
import 'CameraBody/CameraScreen.dart';
import 'ResultBody/ResultScreen.dart';
import 'UploadBody/UploadScreen.dart';
import '../../../generated/l10n.dart';

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
        List bodyScreens = [const UploadScreen(), CameraScreen(), const ResultScreen()];
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Image.asset('assets/logo_3.png')),
                ),
                ListTile(
                    leading: Icon(Icons.home),
                    title: Text(S.of(context).navbar_home),
                    onTap: () {
                      cubit.ChangeTabIndex(0);
                    }),
                ListTile(
                    leading: Icon(Icons.person_sharp),
                    title: Text(S.of(context).navbar_profile),
                    onTap: () {
                      cubit.ChangeTabIndex(1);
                    }),
                ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text(S.of(context).navbar_history),
                    onTap: () {
                      cubit.ChangeTabIndex(2);
                    }),
                ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(S.of(context).navbar_settings),
                    onTap: () {
                      cubit.ChangeTabIndex(3);
                    }),
              ],
            ),
          ),
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
