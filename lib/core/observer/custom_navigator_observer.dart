import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  final VoidCallback onPopComplete;

  CustomNavigatorObserver({required this.onPopComplete});

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // 画面が完全にポップされた後にコールバックを実行
    onPopComplete();
  }
}
