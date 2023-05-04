import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        String res = S.of(context).anemic;
        Color color;
        if (state is TestDone) {
          if (cubit.test_result == 'Anemic') {
            color = Color(0xFFCE772F);
          } else {
            color = Color(0xFF29C469);
            res = S.of(context).not_anemic;
          }
          return TweenAnimationBuilder<double>(
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
              });
        }
        if (state is WaitingResult) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.threeArchedCircle(
                  color: Color(0xFFF05454), size: 75),
              SizedBox(
                height: 5.h,
              ),
              Text(
                S.of(context).pls_wait,
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xFF3177A3),
                ),
              ),
            ],
          ));
        } else {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/resultc.png'),
            )),
            child: Center(
              child: Text(
                S.of(context).take_test_first,
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }
}
