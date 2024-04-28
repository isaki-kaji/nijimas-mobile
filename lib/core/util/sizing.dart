import 'package:flutter/material.dart';

class Sizing {
  static double widthByMQ(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double heightByMQ(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  static double imageHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.2;
  }

  static double imageWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.6;
  }
}
