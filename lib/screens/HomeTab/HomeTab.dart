import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  label: S.of(context).navbar_home,
                  onTap: () {
                    cubit.ChangeTabIndex(0);
                  }),
              SidebarXItem(
                  icon: Icons.person_sharp,
                  label: S.of(context).navbar_profile,
                  onTap: () {
                    cubit.ChangeTabIndex(1);
                  }),
              SidebarXItem(
                  icon: Icons.photo_library_outlined,
                  label: S.of(context).navbar_history,
                  onTap: () {
                    cubit.ChangeTabIndex(2);
                  }),
              SidebarXItem(
                  icon: Icons.settings,
                  label: S.of(context).navbar_settings,
                  onTap: () {
                    cubit.ChangeTabIndex(3);
                  }),
            ],
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
