import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/application/usecase/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  Stream<User?> build() {
    final auth = ref.read(authUseCaseProvider);
    return auth.authStateChanges;
  }

  bool get isSignedIn => state.valueOrNull != null;
}
