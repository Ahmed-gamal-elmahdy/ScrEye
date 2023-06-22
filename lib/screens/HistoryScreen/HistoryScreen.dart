import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

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
            drawer: myDrawer(context),
            appBar: AppBar(
              actions: [
                IconButton(
                    tooltip: "Logout",
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
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
                    if (snapshot.data?.value == null) {
                      return Text(
                        S.of(context).history_empty_error,
                        style: TextStyle(fontSize: 15.w, color: Colors.red),
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
                        var color;
                        var res = S.of(context).anemic;
                        DateTime dateTime =
                            DateTime.fromMillisecondsSinceEpoch(value["time"]);
                        String formattedDate =
                            DateFormat.yMMMMd().format(dateTime);
                        String formattedTime =
                            DateFormat.jms().format(dateTime);
                        if (value["result"] == 'Anemic') {
                          color = Color(0xFFCE772F);
                        } else {
                          color = Color(0xFF29C469);
                          res = S.of(context).not_anemic;
                        }
                        return ExpansionTile(
                          title: Text('$formattedDate $formattedTime'),
                          subtitle: Text(
                            res,
                            style: TextStyle(fontSize: 15.w, color: color),
                          ),
                          leading: Container(
                            width: 50.w,
                            height: 100.h,
                            child: Image.network(
                              value["url"],
                              fit: BoxFit.cover,
                            ),
                          ),
                          children: [
                            Image.network(
                              value["url"],
                              fit: BoxFit.cover,
                            ),
                            OutlinedButton.icon(
                              label: Text(
                                S.of(context).save, /*style: TextStyle(color: Color(0xFFF05454),*/
                              ),
                              icon: const Icon(
                                Icons.download, /*color: Color(0xFFF05454)*/
                              ),
                              onPressed: () async {},
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Theme.of(context).textTheme.headline3!.color!,
                          thickness: 2,
                          height: 10,
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
