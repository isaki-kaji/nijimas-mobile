import 'package:flutter/material.dart';

class MyTextStyles {
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

  static const TextStyle category = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body36 =
      TextStyle(fontSize: 36, fontWeight: FontWeight.w400);

  static const TextStyle body16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle body14 = TextStyle(
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 10,
  );
}
