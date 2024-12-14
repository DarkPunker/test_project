import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Responsive {
  late double width, height, diagonal;
  late bool isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    diagonal = math.sqrt(math.pow(width, 2) + math.pow(height, 2));

    isTablet = size.shortestSide >= 600;
  }

  double wp(double percent) {
    return width * percent / 100;
  }

  double hp(double percent) {
    return height * percent / 100;
  }

  double dp(double percent) {
    return diagonal * percent / 100;
  }
}
