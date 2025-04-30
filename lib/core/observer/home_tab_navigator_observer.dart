import 'package:flutter/material.dart';

class HomeTabNavigatorObserver extends NavigatorObserver {
  final VoidCallback onAllScreensPopped;

  HomeTabNavigatorObserver({required this.onAllScreensPopped});

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    if (navigator?.canPop() == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onAllScreensPopped();
      });
    }
  }
}
