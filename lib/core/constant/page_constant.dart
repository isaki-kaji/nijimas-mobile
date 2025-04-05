import 'package:flutter/material.dart';
import 'package:nijimas/core/model/year_month.dart';
import 'package:nijimas/presentation/screen/data/data_screen.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';
import 'package:nijimas/presentation/screen/notification/notification_screen.dart';
import 'package:nijimas/presentation/screen/other/other_screen.dart';

class PageConstants {
  static Widget getTabPage(int index, YearMonth yearMonth) {
    switch (index) {
      case 0:
        return const FeedScreen();
      case 1:
        return DataScreen(
            year: yearMonth.year.toString(), month: yearMonth.month.toString());
      case 2:
        return const NotificationScreen();
      case 3:
        return const OtherScreen();
      default:
        throw Exception('Invalid tab index');
    }
  }
}
