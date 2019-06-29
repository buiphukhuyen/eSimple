import 'package:english_app/src/resources/widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopBar extends StatelessWidget {
  final String text;
  TopBar(this.text);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CustomPaint(
        child: Container(
          height: 210.0,
        ),
        painter: CurvesPainter(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }
}

class CurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.21, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.4,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = thirdColor;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.20,
        size.width * 0.1, size.height * 0.40);
    path.quadraticBezierTo(
        size.width * 0.42, size.height, size.width * 0.465, size.height * 0.76);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = secondColor;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.20, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = firstColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
