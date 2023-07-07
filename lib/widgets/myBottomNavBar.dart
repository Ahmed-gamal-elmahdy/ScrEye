import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';

Widget myBottomNavBar(BuildContext context, int selectedIndex) {
  return ConvexAppBar(
    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
    activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
    curveSize: 90,
    top: -25,
    height: 50.h,
    items: [
      TabItem(
        title: S.of(context).upload,
        icon: Icon(
          Icons.upload,
          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        activeIcon: Icon(
          Icons.upload,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      TabItem(
        title: S.of(context).camera,
        icon: Icon(
          Icons.camera_alt_outlined,
          color: Theme.of(context).textTheme.headline2!.color!,
        ),
      ),
      TabItem(
        title: S.of(context).result,
        icon: Icon(
          Icons.insert_drive_file_outlined,
          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
        activeIcon: Icon(
          Icons.insert_drive_file_outlined,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
    ],
    initialActiveIndex: selectedIndex,
    onTap: (int index) {
      switch (index) {
        case 0:
          Navigator.popAndPushNamed(context, '/upload');
          break;
        case 1:
          Navigator.popAndPushNamed(context, '/capture');
          break;
        case 2:
          Navigator.popAndPushNamed(context, '/result');
          break;
        default:
          throw Exception("Invalid tab index: $index");
      }
    },
    style: TabStyle.fixedCircle,
  );
}
