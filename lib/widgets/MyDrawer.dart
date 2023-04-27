import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../generated/l10n.dart';

class MyDrawer {
  static SidebarX originalDrawer(context, cubit) {
    return SidebarX(
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
    );
  }
}
