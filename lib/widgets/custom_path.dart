import 'package:flutter/material.dart';

// Path to be cropped
Path clipPath({required double width, required double height}) {

  Path path = Path();
  path.moveTo(width * 0.3283333, height * 0.4925000);
  path.cubicTo(width * 0.4100000, height * 0.6243750, width * 0.4116667,
      height * 0.6193750, width * 0.5000000, height * 0.6250000);
  path.cubicTo(width * 0.5870833, height * 0.6250000, width * 0.5829167,
      height * 0.6275000, width * 0.6700000, height * 0.4950000);
  path.cubicTo(width * 0.6758333, height * 0.6025000, width * 0.6008333,
      height * 0.7675000, width * 0.5000000, height * 0.7550000);
  path.cubicTo(width * 0.4420833, height * 0.7268750, width * 0.3437500,
      height * 0.7243750, width * 0.3283333, height * 0.4925000);
  path.close();

  return path;
}

// path to eye circle
Path circlePath({required double width, required double height}) {
  Path path = Path();

  path.moveTo(width * 0.5000000, height * 0.2444250);
  path.cubicTo(width * 0.5630333, height * 0.2609750, width * 0.6687333,
      height * 0.3152000, width * 0.6687333, height * 0.4975000);
  path.cubicTo(width * 0.6687333, height * 0.5986750, width * 0.6180667,
      height * 0.7506000, width * 0.5000000, height * 0.7506000);
  path.cubicTo(width * 0.4325667, height * 0.7506000, width * 0.3312833,
      height * 0.6746000, width * 0.3312833, height * 0.4975000);
  path.cubicTo(width * 0.3312833, height * 0.3963500, width * 0.3896667,
      height * 0.2609750, width * 0.5000000, height * 0.2444250);
  path.close();

  return path;
}

// painter to draw guideline circle shape
class Guideline_Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Path path0 = clipPath(width: size.width, height: size.height);
    canvas.drawPath(path0, paint0);

    // Paint paint1 = Paint()
    //   ..color = const Color.fromARGB(255, 33, 150, 243)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1;
    //
    // Path path1 = circlePath(width: size.width, height: size.height);
    // canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Widget Guideline_Widget({required double width}) {
  return CustomPaint(
    size: Size(width, (width * 0.67).toDouble()),
    painter: Guideline_Painter(),
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return clipPath(width:size.width, height: (size.width * 0.67).toDouble());
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
