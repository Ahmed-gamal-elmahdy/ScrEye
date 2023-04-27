
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../generated/l10n.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);

        return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.16,
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
          appBar: AppBar(
            actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    FirebaseUIAuth.signOut();
                  },
                  icon: Icon(Icons.power_settings_new_rounded))
            ],
            title: Text(S.of(context).navbar_settings),
          ),
          body: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("arbic : "),
                      ElevatedButton(onPressed: (){
                        cubit.ChangeLanguage(lang: "ar");
                      }, child: Text("ar"))
                    ],
                  ),
                  Row(
                    children: [
                      Text("eng : "),
                      ElevatedButton(onPressed: (){
                        cubit.ChangeLanguage(lang: "en");
                      }, child: Text("en"))
    
                     
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
