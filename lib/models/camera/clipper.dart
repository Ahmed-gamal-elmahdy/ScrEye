import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/custom_path.dart';
import 'package:screenshot/screenshot.dart';

class ClipperScreen extends StatefulWidget {
  const ClipperScreen({Key? key}) : super(key: key);

  @override
  State<ClipperScreen> createState() => _ClipperScreenState();
}

class _ClipperScreenState extends State<ClipperScreen> {
  Size imsize = new Size(300, 200);
  Image gImage = Image.network(
      "https://s1.econotimes.com/assets/uploads/20200121045abbd6c458bb8d6_th_1024x0.jpg");
  late Image clippedImage;
  ScreenshotController screenshotController = ScreenshotController();
  bool isClipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clipper"),
      ),
      body: Column(
        children: [
          Text(
            "Image Preview",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 15),
          Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                ClipPath(
                  child: gImage,
                  clipper: MyClipper(),
                ),
/*
                Container(
                  padding: EdgeInsets.all(5),
                  height: 200,
                  width: 300,
                  child: FittedBox(
                    child: gImage,
                    //fit: BoxFit.fill,
                  ),
                ),
                CustomPaint(
                  size: Size(imsize.width, (imsize.width * 0.585).toDouble()),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
*/
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(isClipped.toString()),
          Container(
            padding: EdgeInsets.all(5),
            height: 200,
            width: 300,
            child: isClipped
                ? clippedImage
                : Image.network(
                    "https://findicons.com/files/icons/2396/emoji/200/emoji8.png"),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  screenshotController.capture().then((capImg) {
                    clippedImage = Image.memory(capImg!);
                  });
                },
                child: Text("Clip")),
          ),
          FloatingActionButton(onPressed: () {
            setState(() {
              isClipped = true;
              print("false");
            });
          })
        ],
      ),
    );
  }
}
