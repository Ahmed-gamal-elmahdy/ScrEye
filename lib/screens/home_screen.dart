import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/screens/HistoryTab/HistoryTab.dart';
import 'package:fluttertest/screens/HomeTab/HomeTab.dart';

import 'ProfileTab/ProfileTab.dart';
import 'SettingsTab/MySettingsScreen.dart';

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
          List tabScreens = [
            HomeTab(),
            ProfileTab(),
            HistoryTab(),
            SettingsScreen()
          ];
          var cubit = AppCubit.get(context);
          if (!cubit.cameraInitiated) {
            cubit.startCamera();
            cubit.user = user;
          }
          return tabScreens[cubit.tabIndex];
        },
      ),
    );
  }
}
