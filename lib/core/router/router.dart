import 'package:flutter/material.dart';
import 'package:nijimas/screens/auth/login_screen.dart';
import 'package:nijimas/screens/home/home_screen.dart';
import 'package:nijimas/screens/nijimas/do_nijimas_screen.dart';
import 'package:nijimas/screens/post/add_post_screen.dart';
import 'package:nijimas/screens/user_profile/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {"/": (_) => const MaterialPage(child: LoginScreen())});

final loggedInRoute = RouteMap(routes: {
  "/": (_) => const MaterialPage(child: HomeScreen()),
  "/user/:uid": (routeData) => MaterialPage(
          child: UserProfileScreen(
        uid: routeData.pathParameters['uid']!,
      )),
  "/do-nijimas": (_) => const MaterialPage(child: DoNijimasScreen()),
  "/add-post": (_) => const MaterialPage(child: AddPostScreen()),
});
