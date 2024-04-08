import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/repository/user_status_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_first_signin_provider.g.dart';

@riverpod
Future<bool> isFirstSignin(IsFirstSigninRef ref) async {
  final user = ref.read(authStateProvider).value;
  final userStatus =
      await ref.read(userStatusRepositoryProvider).getUserStatus(user!);
  return userStatus!.isFirstSignIn;
}
