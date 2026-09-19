// lib/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fontSize(BuildContext context, double size) {
    double scale = screenWidth(context) / 375;
    double newSize = size * scale;
    return newSize.clamp(size * 0.7, size * 1.2);
  }

  static double padding(BuildContext context, double size) {
    double scale = screenWidth(context) / 375;
    double newSize = size * scale;
    return newSize.clamp(size * 0.6, size * 1.2);
  }

  static double width(BuildContext context, double size) {
    double scale = screenWidth(context) / 375;
    return size * scale;
  }

  static double height(BuildContext context, double size) {
    double scale = screenHeight(context) / 812;
    return size * scale.clamp(0.7, 1.2);
  }

  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 375;
  }

  static bool isMediumScreen(BuildContext context) {
    return screenWidth(context) >= 375 && screenWidth(context) < 600;
  }

  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 600;
  }

  static int gridColumns(BuildContext context) {
    if (screenWidth(context) < 360) return 2;
    if (screenWidth(context) < 600) return 2;
    return 3;
  }

  static double cardAspectRatio(BuildContext context) {
    if (screenWidth(context) < 360) return 1.0;
    return 1.2;
  }
}
