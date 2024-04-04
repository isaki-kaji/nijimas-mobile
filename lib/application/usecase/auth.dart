import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_auth.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';

final authUseCaseProvider = Provider<AbstractAuthUsecase>((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase extends AbstractAuthUsecase {
  final AbstractAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  @override
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  @override
  Future<User?> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    if (user != null) {
      await _authRepository.registerUserStatus(user);
    }
    return user;
  }

  @override
  Future<User?> signInAsGuest() async {
    return await _authRepository.signInAsGuest();
  }

  @override
  Future<void> signOut() async {
    return await _authRepository.signOut();
  }
}
