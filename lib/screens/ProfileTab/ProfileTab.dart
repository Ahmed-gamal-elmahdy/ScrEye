
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';

import '../../../generated/l10n.dart';
import '../../widgets/MyDrawer.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);

        return Scaffold(
          drawer: myDrawer(context, cubit),
          appBar: AppBar(
            actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () {
                    FirebaseUIAuth.signOut();
                  },
                  icon: Icon(Icons.power_settings_new_rounded))
            ],
            title: Text(S.of(context).navbar_profile),
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Name : "),

                  ],
                ),
                Row(
                  children: [
                    Text("Email : "),

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
