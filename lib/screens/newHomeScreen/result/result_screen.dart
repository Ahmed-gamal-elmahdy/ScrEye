import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/widgets/MyDrawer.dart';

import '../../../cubit/AppSettingsCubit/app_settings_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../themes/MyTheme.dart';
import '../../../widgets/myBottomNavBar.dart';

class ResultScreen extends StatelessWidget {

  const ResultScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String? resultFromArguments = arguments?['result'];

    String res = S.of(context).anemic;
    Color color;
    var settingCubit = BlocProvider.of<AppSettingsCubit>(context);
    var bg = 'assets/resultc_dark.png';
    if (settingCubit.state.themeMode == ThemeMode.whiteTheme) {
      bg = 'assets/resultc.png';
    } else if (settingCubit.state.themeMode == ThemeMode.darkTheme) {
      bg = 'assets/resultc_dark.png';
    } else {
      bg = 'assets/resultc_cb.png';
    }
    if (resultFromArguments == 'Anemic') {

      color = Color(0xFFCE772F);
    } else {
      color = Color(0xFF29C469);
      res = S.of(context).not_anemic;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).result),
      ),
      drawer: myDrawer(context),
      bottomNavigationBar: myBottomNavBar(context, 2),
      body: Center(
        child: resultFromArguments != null
            ? TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.ease,
            duration: const Duration(seconds: 2),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                opacity: opacity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).you_are,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        res,
                        style: TextStyle(fontSize: 50, color: color),
                      ),
                    ],
                  ),
                ),
              );
            })
            : Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bg),
              )),
          child: Center(
            child: Text(
              S.of(context).take_test_first,
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w100,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}