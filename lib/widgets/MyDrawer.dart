import 'package:flutter/material.dart';

import '../generated/l10n.dart';

Drawer myDrawer(context, cubit) {
  return Drawer(
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
  );
}
