import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class TextStyles {
  static TextStyle title(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: MyColors.whiteColor);
  }

  static TextStyle push() {
    return const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: MyColors.pinkColor);
  }

  static TextStyle description(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.normal,
        color: MyColors.whiteColor);
  }
}
