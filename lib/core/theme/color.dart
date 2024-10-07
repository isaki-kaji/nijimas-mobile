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

  static const teal = Colors.teal;
  static const tealAccent = Colors.tealAccent;
  static const pink = Color(0xFFFF6969);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const lightGrey = Color(0xFFe6e6e6);
  static const black = Colors.black;
  static const lightGreen = Colors.lightGreen;

  static Color getActivityNumbersColor(int numbers) {
    if (numbers == 0) {
      return Colors.transparent;
    } else if (numbers == 1) {
      return teal.withOpacity(0.1);
    } else if (numbers <= 3) {
      return teal.withOpacity(0.3);
    } else if (numbers <= 5) {
      return teal.withOpacity(0.5);
    } else if (numbers <= 8) {
      return teal.withOpacity(0.8);
    } else {
      return teal;
    }
  }

  static Color getActivityAmountsColor(double amount) {
    if (amount == 0) {
      return Colors.transparent;
    } else if (amount < 1000) {
      return teal.withOpacity(0.1);
    } else if (amount < 3000) {
      return teal.withOpacity(0.3);
    } else if (amount < 10000) {
      return teal.withOpacity(0.5);
    } else if (amount < 50000) {
      return teal.withOpacity(0.8);
    } else {
      return teal;
    }
  }

  static Color? getSubCategoryPercentColor(double percent) {
    if (percent < 2) {
      return null;
    } else if (percent < 5) {
      return Colors.pink[50]!;
    } else if (percent < 10) {
      return Colors.pink[100]!;
    } else if (percent < 20) {
      return Colors.pink[200]!;
    } else if (percent < 30) {
      return Colors.pink[300]!;
    } else {
      return Colors.pink[400]!;
    }
  }

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
