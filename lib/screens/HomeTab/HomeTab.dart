import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:sidebarx/sidebarx.dart';
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
          "Upload",
          "Align Clipper with Conjunctiva",
          "Results",
        ];
        List bodyScreens = [UploadScreen(), CameraScreen(), ResultScreen()];
        return Scaffold(
          drawer: SidebarX(

            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),

                ),
              );
            },
            controller: cubit.sideBar_controller,
            items: [
              SidebarXItem(
                  icon: Icons.home,
                  label: 'Home',
                  onTap: () {
                    cubit.ChangeTabIndex(0);
                  }),
              SidebarXItem(
                  icon: Icons.person_sharp,
                  label: 'Profile',
                  onTap: () {
                    cubit.ChangeTabIndex(1);
                  }),
              SidebarXItem(
                  icon: Icons.photo_library_outlined,
                  label: 'History',
                  onTap: () {
                    cubit.ChangeTabIndex(2);
                  }),
              SidebarXItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    cubit.ChangeTabIndex(3);
                  }),
            ],
          ),
          appBar: AppBar(actions: [
            IconButton(
                tooltip: "Logout",
                onPressed: () {
                  FirebaseUIAuth.signOut();
                },
                icon: Icon(Icons.power_settings_new_rounded))
          ], title: Text(bodyNames[cubit.bodyIndex])),
          body: bodyScreens[cubit.bodyIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bodyIndex,
            items: [
              BottomNavigationBarItem(
                  label: "Upload",
                  icon: IconButton(
                      icon: Icon(Icons.upload),
                      onPressed: () {
                        cubit.ChangeBodyIndex(0);
                      })),
              BottomNavigationBarItem(
                  label: "Camera",
                  icon: IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        cubit.ChangeBodyIndex(1);
                      })),
              BottomNavigationBarItem(
                  label: "Result",
                  icon: IconButton(
                      icon: Icon(Icons.insert_drive_file_outlined),
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
