import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class Navigators {
  static void toHome(BuildContext context) {}
  static void toUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/user/$uid');
  }
}
