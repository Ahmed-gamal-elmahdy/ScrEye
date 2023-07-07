import 'dart:io';

import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/newHomeScreen/upload/uploadCubit/upload_cubit.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:fluttertest/widgets/myBottomNavBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../cubit/AppSettingsCubit/app_settings_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../themes/MyTheme.dart';

class UploadScreen extends StatelessWidget {
  String imagePath;

  UploadScreen({Key? key, this.imagePath = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String? pathFromArguments = arguments?['imagePath'];
    if (pathFromArguments != null) {
      imagePath = pathFromArguments;
    }
    return BlocProvider(
      create: (context) =>
          UploadCubit(imagePath: imagePath.isNotEmpty ? imagePath : null),
      child: BlocBuilder<UploadCubit, UploadState>(
        builder: (context, state) {
          final uploadCubit = context.read<UploadCubit>();
          var uploadInProgress = uploadCubit.uploadInProgress;
          var settingCubit = BlocProvider.of<AppSettingsCubit>(context);
          var bg = 'assets/homec_dark.png';
          if (settingCubit.state.themeMode == ThemeMode.whiteTheme) {
            bg = 'assets/homec.png';
          } else if (settingCubit.state.themeMode == ThemeMode.darkTheme) {
            bg = 'assets/homec_dark.png';
          } else {
            bg = 'assets/homec.png';
          } // Access the flag
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).upload),
            ),
            bottomNavigationBar: myBottomNavBar(context, 0),
            drawer: myDrawer(context),
            body: Center(
              child: state is UploadImageLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300.h,
                          width: 300.w,
                          child: Image.file(
                            File(state.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        uploadInProgress
                            ? OutlinedButton(
                                style: ButtonStyle(
                                    backgroundColor: Theme.of(context)
                                        .outlinedButtonTheme
                                        .style
                                        ?.shadowColor),
                                onPressed: null,
                                child: IntrinsicWidth(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LoadingAnimationWidget.threeArchedCircle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .color!,
                                          size: 20),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Text(S.of(context).uploading)
                                    ],
                                  ),
                                ),
                              )
                            : OutlinedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: Theme.of(context)
                                        .outlinedButtonTheme
                                        .style
                                        ?.shadowColor),
                                label: Text(
                                  S
                                      .of(context)
                                      .upload, /*style: TextStyle(color: Color(0xFFF05454),*/
                                ),
                                icon: const Icon(
                                  Icons.upload, /*color: Color(0xFFF05454)*/
                                ),
                                onPressed: () {
                                  uploadCubit.uploadImage();
                                },
                              ),
                        OutlinedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: Theme.of(context)
                                  .outlinedButtonTheme
                                  .style
                                  ?.shadowColor),
                          label: Text(
                            S
                                .of(context)
                                .discard, /*style: TextStyle(color: Color(0xFFF05454),*/
                          ),
                          icon: const Icon(
                            Icons.delete_forever, /*color: Color(0xFFF05454)*/
                          ),
                          onPressed: () {
                            uploadCubit.cancelUpload();
                          },
                        )
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(bg),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).taken_photo_upload,
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          OutlinedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: Theme.of(context)
                                    .outlinedButtonTheme
                                    .style
                                    ?.shadowColor),
                            label: Text(
                              S
                                  .of(context)
                                  .choose_img, /*style: TextStyle(color: Color(0xFFF05454),*/
                            ),
                            icon: const Icon(
                              Icons.upload, /*color: Color(0xFFF05454)*/
                            ),
                            onPressed: () {
                              uploadCubit.pickImage();
                            },
                          )
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
