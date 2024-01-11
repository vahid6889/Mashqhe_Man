import 'dart:math';

class Circle {
  final double radius;
  final Point center;

  Circle(this.radius, this.center);

  double get area => pi * pow(radius, 2);
}
