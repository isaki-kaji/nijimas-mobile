import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/user_status_provider.dart';
import 'package:nijimas/application/state/users_info_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/guest/guest_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';
import 'package:nijimas/presentation/screen/other/privacy_policy_screen.dart';
import 'package:nijimas/presentation/screen/other/terms_of_service_screen.dart';
import 'package:nijimas/presentation/screen/post/add_post_screen.dart';
import 'package:nijimas/presentation/screen/user/register_user_screen.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/core/util/build_transition_page.dart';
import 'package:nijimas/presentation/screen/user/user_edit_screen.dart';
import 'package:nijimas/presentation/screen/user/users_screen.dart';
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
              return buildTransitionPage(child: HomeScreen());
            }
            return MaterialPage(child: HomeScreen());
          }),
      GoRoute(
          path: '/post/add',
          pageBuilder: (context, state) {
            return MaterialPage(child: AddPostScreen(), fullscreenDialog: true);
          }),
      GoRoute(
          path: '/post/edit',
          pageBuilder: (context, state) {
            final post = state.extra as Post?;
            return MaterialPage(
              child: AddPostScreen(editingPost: post),
              fullscreenDialog: true,
            );
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
      ),
      GoRoute(
        path: '/users/:uid/followers',
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          return UsersScreen(uid: uid!, type: UserRelationType.followers);
        },
      ),
      GoRoute(
        path: '/users/:uid/followings',
        builder: (context, state) {
          final uid = state.pathParameters['uid'];
          return UsersScreen(uid: uid!, type: UserRelationType.followings);
        },
      ),
      GoRoute(
          path: '/terms',
          builder: (context, state) => const TermsOfServiceScreen()),
      GoRoute(
          path: '/privacy',
          builder: (context, state) => const PrivacyPolicyScreen()),
      GoRoute(path: "/guest", builder: (context, state) => const GuestScreen()),
    ],
    redirect: (context, state) async {
      final signedInUser = ref.read(authStateProvider).valueOrNull;
      if (signedInUser == null) {
        return state.matchedLocation == '/signin' ? null : '/signin';
      }
      final isAnonymous = signedInUser.isAnonymous;
      if (isAnonymous) {
        return '/guest';
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
