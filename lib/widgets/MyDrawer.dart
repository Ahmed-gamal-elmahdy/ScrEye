import 'package:flutter/material.dart';

import '../generated/l10n.dart';

Drawer myDrawer(context) {
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.home),
              title: Text(S.of(context).navbar_home),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.person_sharp),
              title: Text(S.of(context).navbar_profile),
              onTap: () {
                Navigator.popAndPushNamed(context, '/profile');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text(S.of(context).navbar_history),
              onTap: () {
                Navigator.popAndPushNamed(context, '/history');
              }),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).navbar_settings),
              onTap: () {
                Navigator.popAndPushNamed(context, '/settings');
              }),
        ),
        /*
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 15.0,
            ),
          ),
          child: ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text("Collect Data"),
              onTap: () {
                Navigator.popAndPushNamed(context, '/capture');
              }),
        ),

         */
      ],
    ),
  );
}
