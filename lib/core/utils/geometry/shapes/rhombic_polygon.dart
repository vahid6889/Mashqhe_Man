import 'package:flutter/material.dart';

class RhombicPolygon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path = Path();
    path.moveTo(size.width * 0.2705274, size.height * 0.2871429);
    path.lineTo(size.width * 0.1650000, size.height * 0.3309858);
    path.lineTo(size.width * 0.2712309, size.height * 0.3748288);
    path.lineTo(size.width * 0.3767583, size.height * 0.3312801);
    path.lineTo(size.width * 0.2705274, size.height * 0.2871429);
    path.close();

    canvas.drawPath(path, paintFill);

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.006
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
