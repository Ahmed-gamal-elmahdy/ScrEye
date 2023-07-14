import 'dart:io';

import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/newHomeScreen/upload/uploadCubit/upload_cubit.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:fluttertest/widgets/myBottomNavBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertest/themes/MyTheme.dart' show ThemeMode;
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
          bool uploadInProgress = uploadCubit.uploadInProgress;
          bool segmentationInProgress = uploadCubit.segmentationInProgress;
          bool isSegmented = uploadCubit.isSegmented;
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
                  SizedBox(
                    height: 280.h,
                    width: 300.w,
                    child: Image.file(
                      File(state.imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 16),
                  isSegmented
                      ? Container()
                      : segmentationInProgress
                      ? TextButton(
                    style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.shadowColor),
                    onPressed: null,
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget
                              .threeArchedCircle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .color!,
                              size: 20),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(S.of(context).loading,style: TextStyle(
                              color: Theme.of(context).textTheme.headline5?.color
                  ))
                        ],
                      ),
                    ),
                  )
                      : TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.shadowColor),
                    label: Text(S.of(context).segment

                    ),
                    icon: const Icon(
                      Icons
                          .image_search_rounded, /*color: Color(0xFFF05454)*/
                    ),
                    onPressed: () {
                      uploadCubit.getSegmented(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      thickness: 1,
                      indent: 100.w,
                      endIndent: 100.w,
                    ),
                  ),
                  uploadInProgress
                      ? TextButton(
                    style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.shadowColor),
                    onPressed: null,
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget
                              .threeArchedCircle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .color!,
                              size: 20),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(S.of(context).uploading,style: TextStyle(
                            color: Theme.of(context).textTheme.headline5?.color
                          ),)
                        ],
                      ),
                    ),
                  )
                      : TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.shadowColor),
                    label: Text(S.of(context).analyze

                    ),
                    icon: const Icon(
                      Icons.upload,
                    ),
                    onPressed: () {
                      uploadCubit.uploadImage(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      thickness: 1,
                      indent: 100.w,
                      endIndent: 100.w,
                    ),
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor: Theme.of(context)
                            .outlinedButtonTheme
                            .style
                            ?.shadowColor),
                    label: Text(
                      S
                          .of(context)
                          .save
                    ),
                    icon: const Icon(
                      Icons
                          .save_alt_outlined
                    ),
                    onPressed: () {
                      uploadCubit.saveImage(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Divider(
                      thickness: 1,
                      indent: 100.w,
                      endIndent: 100.w,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: Theme.of(context)
                          .outlinedButtonTheme
                          .style
                          ?.shadowColor,
                    ),

                    label: Text(S.of(context).discard,style: TextStyle(color: Theme.of(context)
                        .textTheme
                        .headline5!
                        .color!),),
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context)
                          .textTheme
                          .headline5!
                          .color!,
                    ),

                    onPressed: () {
                      uploadCubit.cancel();
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
                            .choose_img,
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