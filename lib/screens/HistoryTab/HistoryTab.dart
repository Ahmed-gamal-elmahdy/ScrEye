
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:sidebarx/sidebarx.dart';


class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);

        return Scaffold(
          drawer: SidebarX(
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
          ], title: Text("History"),
          ),
          body: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("img : "),

                    ],
                  ),
                  Row(
                    children: [
                      Text("img : "),
                     
                    ],
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}
