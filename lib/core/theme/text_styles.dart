import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class TextStyles {
  static TextStyle title(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: MyColors.whiteColor);
  }

  static TextStyle appBarTitle() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.blackColor);
  }

  static TextStyle subTitle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.blackColor);
  }

  static TextStyle push() {
    return const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: MyColors.pinkColor);
  }

  static TextStyle tag() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w200, color: Colors.black54);
  }

  static TextStyle description(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.normal,
        color: MyColors.whiteColor);
  }

  static TextStyle sectionCard() {
    return const TextStyle(color: MyColors.whiteColor, fontSize: 18.0);
  }
}
