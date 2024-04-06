import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle bigTitle(BuildContext context, Color color) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width / 8,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 10,
  );
}
