import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/application/usecase/user_status_usecase.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';
import 'package:nijimas/presentation/screen/user/register_user_scree.dart';
import 'package:nijimas/presentation/screen/user/user_profile_screen.dart';

final routerProvider = Provider((ref) => GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
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
        final signedInUser = ref.read(authUsecaseProvider).currentUser;
        final isAnonymous = signedInUser?.isAnonymous ?? true;
        if (signedInUser == null) {
          return state.matchedLocation == '/signin' ? null : '/signin';
        }
        final isFirstSignIn =
            await ref.read(userStatusUseCaseProvider).isFirstSignIn();
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
    ));
