import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mashgh/core/utils/geometry/shapes/circle.dart';
import 'package:mashgh/core/utils/geometry/shapes/polygon.dart';
import 'package:mashgh/core/utils/geometry/shapes/rhombic_polygon.dart';

class Geometry {
  static Rect createRect() {
    double width = 30;
    double height = width;

    return Rect.fromLTWH(
      0,
      0,
      width,
      height,
    );
  }

  static Circle createCircle() {
    double radius = 5.0;
    Point center = const Point(0, 0);

    return Circle(radius, center);
  }

  static CustomPainter createPolygon({
    bool? hexagon,
    bool? pentagon,
    bool? rhombic,
    bool? triangle,
  }) {
    int numberOfSides = 3;
    const radius = 30.0;

    if (pentagon == true) numberOfSides = 5;
    if (hexagon == true) numberOfSides = 6;
    if (rhombic == true) return RhombicPolygon();
    if (triangle == true) numberOfSides = numberOfSides;

    final points = List.generate(numberOfSides, (index) {
      final angle = index * pi / (numberOfSides / 2);
      final x = cos(angle) * radius;
      final y = sin(angle) * radius;
      return Offset(x, y);
    });

    return Polygon(Path()..addPolygon(points, true));
  }
}
