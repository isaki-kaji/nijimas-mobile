import 'package:flutter/material.dart';

class MyColors {
  static const greyColor = Color.fromRGBO(26, 39, 45, 1);
  static const whiteColor = Color(0XFFF8F8F8);
  static const blackColor = Color(0xFF010101);
  static const brownColor = Color(0xFF8c3333);
  static const lightGreen = Color(0xFFA2C579);
  static const pinkColor = Color(0xFFFF6969);
  static const yellowColor = Color(0xFFF2EE9D);
  static var redColor = Colors.red;

  static var myAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: brownColor,
    backgroundColor: whiteColor,
  );
}
