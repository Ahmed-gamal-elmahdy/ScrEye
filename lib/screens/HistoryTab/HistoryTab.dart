import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../generated/l10n.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        final DatabaseReference _database =
            cubit.dbRef.child(cubit.user.uid).child("images");
        return Scaffold(
            drawer: SidebarX(
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
              title: Text(S.of(context).navbar_history),
            ),
            body: Center(
              child: FutureBuilder<DataSnapshot>(
                future: _database.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // Access the data from the DataSnapshot object
                    if(snapshot.data?.value==null){
                      return Text(
                        "No data found",
                        style: TextStyle(fontSize: 15.w,color:Colors.red),
                      );
                    }
                    var data = snapshot.data?.value as Map<dynamic, dynamic>;
                    List keys = data.keys.toList();
                    keys.sort((a, b) => b.compareTo(a));
                    return ListView.separated(
                      padding: EdgeInsets.all(5),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = keys[index];
                        var value = data[key];
                        var color ;
                        var res = S.of(context).anemic;
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value["time"]);
                        String formattedDate = DateFormat.yMMMMd().format(dateTime);
                        String formattedTime = DateFormat.jms().format(dateTime);
                        if (value["result"] == 'Anemic'){
                          color = Color(0xFFCE772F);
                        }
                        else {
                          color = Color(0xFF29C469);
                          res = S.of(context).not_anemic;
                        }
                        return ListTile(
                          title: Text('$formattedDate $formattedTime'),
                          subtitle:     Text(
                            res,
                            style: TextStyle(fontSize: 15.w,color:color),
                          ),
                          trailing:Container(
                            width: 100.w,
                            height: 100.h,
                            child: Image.network(
                              value["url"],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          thickness: 2,
                          height: 3,
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ));
      },
    );
  }
}
