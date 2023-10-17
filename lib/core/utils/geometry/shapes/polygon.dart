import 'package:flutter/material.dart';

class Polygon extends CustomPainter {
  Polygon(this._path);
  final Path _path;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(_path, paintFill);

    Paint paintStroke = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.006
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(_path, paintStroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
