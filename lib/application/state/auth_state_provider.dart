import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<User?> authState(AuthStateRef ref) {
  return ref.watch(authUsecaseProvider).authStateChanges;
}
