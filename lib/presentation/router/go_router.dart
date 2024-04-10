import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/is_first_signin_provider.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';
import 'package:nijimas/presentation/screen/user/register_user_scree.dart';
import 'package:nijimas/presentation/screen/user/user_profile_screen.dart';
import 'package:nijimas/core/util/build_transition_page.dart';
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
        path: '/signin',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
          path: '/user/register',
          builder: (context, state) => const RegisterUserScreen()),
      GoRoute(
          path: '/user/profile',
          builder: (context, state) => const UserProfileScreen())
    ],
    redirect: (context, state) async {
      final signedInUser = ref.read(authStateProvider).valueOrNull;
      if (signedInUser == null) {
        return state.matchedLocation == '/signin' ? null : '/signin';
      }
      final isAnonymous = signedInUser.isAnonymous;
      final isFirstSignIn = await ref.read(isFirstSigninProvider.future);
      if (isFirstSignIn && !isAnonymous) {
        return '/user/register';
      }
      if (isAnonymous) {
        return '/';
      }
      if (state.matchedLocation == '/signin') {
        return '/';
      }
      return null;
    },
  );
}
