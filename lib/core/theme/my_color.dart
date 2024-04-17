import 'package:flutter/material.dart';

class MyColor {
  static List<List<Color>> getWaveColors() {
    const baseColor = Colors.teal;
    const subColor = Colors.tealAccent;
    return [
      [subColor, subColor.shade400],
      [baseColor, baseColor.shade300],
    ];
  }

  static const pink = Color(0xFFFF6969);
  static const white = Colors.white;
}
