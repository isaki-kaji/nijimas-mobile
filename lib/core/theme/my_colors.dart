import 'package:flutter/material.dart';

class MyColors {
  static const greyColor = Color.fromRGBO(26, 39, 45, 1);
  static const whiteColor = Colors.white;
  static const blackColor = Color(0xFF010101);
  static const brownColor = Color(0xFF8c3333);
  static const loaderColor = Color(0xFFA2C579);
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
