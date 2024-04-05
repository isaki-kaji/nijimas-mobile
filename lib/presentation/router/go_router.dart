import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/presentation/screen/auth/auth_screen.dart';
import 'package:nijimas/presentation/screen/home/home_screen.dart';

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
      ],
      redirect: (context, state) {
        final isSignedIn = ref.read(authStateProvider.notifier).isSignedIn;
        if (!isSignedIn) {
          return state.matchedLocation == '/signin' ? null : '/signin';
        }
        if (state.matchedLocation == '/signin') {
          return '/';
        }
        return null;
      },
    ));
