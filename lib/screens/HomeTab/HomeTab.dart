import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/cubit/app_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Center(
          child: Container(
            decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage('assets/homec.png'),
            )
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload A Taken Image",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  state is !Loading ?
                  OutlinedButton.icon(
                    label: Text('Upload',/*style: TextStyle(color: Color(0xFFF05454),*/),
                    icon: Icon(Icons.upload,/*color: Color(0xFFF05454)*/),
                    onPressed: () async {
                      final _imagePicker = ImagePicker();
                      var image = (await _imagePicker.pickImage(
                          source: ImageSource.gallery))!;
                      cubit.uploadImage(image).then((value) {
                        cubit.testGet(imgname: value[0], token: value[1]);
                      });
                    },
                  ): OutlinedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(color: Color(0xFFF05454), size: 20),
                        SizedBox(
                          width: 10.h,
                        ),
                        Text("Loading...")
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}



