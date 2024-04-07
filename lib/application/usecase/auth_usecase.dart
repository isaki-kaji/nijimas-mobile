import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_auth_usecase.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';

final authUsecaseProvider = Provider<AbstractAuthUsecase>((ref) {
  return AuthUsecase(ref.read(authRepositoryProvider));
});

class AuthUsecase extends AbstractAuthUsecase {
  final AbstractAuthRepository _authRepository;

  AuthUsecase(this._authRepository);

  @override
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  @override
  User? get currentUser => _authRepository.currentUser;

  @override
  bool get isAnonymous => _authRepository.isAnonymous;

  @override
  Future<void> signInWithGoogle({required void Function() onFailure}) async {
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      onFailure();
    }
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
