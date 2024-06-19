import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/user_status_provider.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';
import 'package:nijimas/presentation/screen/post/add_post_screen.dart';
import 'package:nijimas/presentation/screen/user/register_user_screen.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/core/util/build_transition_page.dart';
import 'package:nijimas/presentation/screen/user/user_edit_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            final isShowAnimation = state.extra ?? false;
            if (isShowAnimation as bool) {
              return buildTransitionPage(
                  child: HomeScreen(
                isShowAnimation: isShowAnimation,
              ));
            }
            return const MaterialPage(
                child: HomeScreen(isShowAnimation: false));
          }),
      GoRoute(
          path: '/post/add',
          pageBuilder: (context, state) {
            return MaterialPage(child: AddPostScreen(), fullscreenDialog: true);
          }),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
          path: '/user/register',
          builder: (context, state) => const RegisterUserScreen()),
      GoRoute(
        path: '/profile/:uid',
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          return UserDetailScreen(uid: uid!);
        },
      ),
      GoRoute(
        path: '/profile/:uid/edit',
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          return UserEditScreen(uid: uid!);
        },
      )
    ],
    redirect: (context, state) async {
      final signedInUser = ref.read(authStateProvider).valueOrNull;
      if (signedInUser == null) {
        return state.matchedLocation == '/signin' ? null : '/signin';
      }
      final isAnonymous = signedInUser.isAnonymous;
      if (isAnonymous) {
        return '/';
      }
      final userStatus = await ref.read(currentUserStatusProvider.future);
      if (userStatus == null) {
        return '/user/register';
      }
      final isFirstSignIn = userStatus.isFirstSignIn;
      if (isFirstSignIn) {
        return '/user/register';
      }
      if (state.matchedLocation == '/signin') {
        return '/';
      }
      return null;
    },
  );
}
