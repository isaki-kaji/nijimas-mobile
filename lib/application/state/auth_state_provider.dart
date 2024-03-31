import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/application/usecase/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<User?> authStateChange(AuthStateChangeRef ref) {
  final auth = ref.watch(authUseCaseProvider);
  return auth.authStateChanges;
}
