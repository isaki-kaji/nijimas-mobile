import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Stream<User?> build() {
    final auth = ref.read(authUsecaseProvider);
    return auth.authStateChanges;
  }

  bool get isSignedIn => state.valueOrNull != null;
}
