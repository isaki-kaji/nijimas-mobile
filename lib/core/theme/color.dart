import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';

class MyColors {
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
  static const black = Colors.black;
  static const lightGreen = Colors.lightGreen;

  static Color getMainCategoryColor(MainCategory category) {
    switch (category) {
      case MainCategory.food:
        return Colors.pink;
      case MainCategory.hobbies:
        return Colors.blue;
      case MainCategory.fashion:
        return Colors.purple;
      case MainCategory.goods:
        return Colors.orange;
      case MainCategory.essentials:
        return Colors.green;
      case MainCategory.travel:
        return Colors.yellow;
      case MainCategory.entertainment:
        return Colors.red;
      case MainCategory.transport:
        return Colors.brown;
      case MainCategory.other:
        return Colors.grey;
    }
  }
}
