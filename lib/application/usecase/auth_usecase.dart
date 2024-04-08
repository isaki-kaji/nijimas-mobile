import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/abstract_auth_usecase.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';

final authUsecaseProvider = Provider<AbstractAuthUsecase>((ref) {
  return AuthUsecase(ref.read(authRepositoryProvider), ref);
});

class AuthUsecase extends AbstractAuthUsecase {
  final AbstractAuthRepository _authRepository;
  final Ref _ref;

  AuthUsecase(this._authRepository, this._ref);

  @override
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  @override
  User? get currentUser => _authRepository.currentUser;

  @override
  bool get isAnonymous => _authRepository.isAnonymous;

  @override
  Future<void> signInWithGoogle({required void Function() onFailure}) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      await _authRepository.signInWithGoogle();
    } catch (e) {
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  @override
  Future<void> signInAsGuest() async {
    _ref.read(loadingProvider.notifier).setTrue();
    await _authRepository.signInAsGuest();
    _ref.read(loadingProvider.notifier).setFalse();
  }

  @override
  Future<void> signOut() async {
    return await _authRepository.signOut();
  }
}
