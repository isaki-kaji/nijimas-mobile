import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/screen/data/data_screen.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';

class PageConstant {
  static Widget getTabPage(int index, PostQuery query) {
    switch (index) {
      case 0:
        return FeedScreen(query: query);
      case 1:
        return const DataScreen();
      default:
        throw Exception('Invalid tab index');
    }
  }
}
