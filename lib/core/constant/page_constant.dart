import 'package:flutter/material.dart';
import 'package:nijimas/core/model/year_month.dart';
import 'package:nijimas/presentation/screen/data/data_screen.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';

class PageConstant {
  static Widget getTabPage(int index, YearMonth yearMonth) {
    switch (index) {
      case 0:
        return FeedScreen();
      case 1:
        return DataScreen(
            year: yearMonth.year.toString(), month: yearMonth.month.toString());
      default:
        throw Exception('Invalid tab index');
    }
  }
}
