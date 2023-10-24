import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class Navigators {
  static void toHome(BuildContext context) {
    Routemaster.of(context).push('/');
  }

  static void toUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/user/$uid');
  }

  static void toDoNijimas(BuildContext context) {
    Routemaster.of(context).push('/do-nijimas');
  }

  static void toAddPost(BuildContext context) {
    Routemaster.of(context).push('/add-post');
  }

  static void toTakePhoto(BuildContext context) {
    Routemaster.of(context).push('/take-photo');
  }
}
