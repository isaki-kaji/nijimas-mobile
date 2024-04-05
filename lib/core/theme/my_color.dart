import 'package:flutter/material.dart';

class MyColor {
  static List<List<Color>> getWaveColors() {
    const baseColor = Colors.tealAccent;
    const subColor = Colors.teal;
    return [
      [baseColor, baseColor.shade700],
      [
        subColor,
        subColor.shade300,
      ]
    ];
  }
}
