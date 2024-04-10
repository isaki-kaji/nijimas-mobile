import 'package:flutter/material.dart';

class Sizing {
  static double widthByMQ(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double heightByMQ(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }
}
