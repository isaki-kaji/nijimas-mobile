import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/state/user_status_provider.dart';
import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';
import 'package:nijimas/presentation/screen/user/register_user_scree.dart';

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
            path: '/register-user',
            builder: (context, state) => const RegisterUserScreen())
      ],
      redirect: (context, state) async {
        final isAnonymous = ref.read(authUsecaseProvider).isAnonymous;
        final signedInUser = ref.read(authUsecaseProvider).currentUser;
        //未ログインかつサインイン画面にいない場合はサインイン画面にリダイレクト
        if (signedInUser == null) {
          return state.matchedLocation == '/signin' ? null : '/signin';
        }
        final isFirstSignIn =
            await ref.read(userStatusProvider.notifier).isFirstSignIn();
        if (isFirstSignIn && !isAnonymous) {
          return '/register-user';
        }
        return '/';
      },
    ));
