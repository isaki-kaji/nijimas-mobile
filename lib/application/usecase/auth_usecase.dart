import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_auth_usecase.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

final authUsecaseProvider = Provider<AbstractAuthUsecase>((ref) {
  return AuthUsecase(
      ref.read(authRepositoryProvider), ref.read(userStatusRepositoryProvider));
});

class AuthUsecase extends AbstractAuthUsecase {
  final AbstractAuthRepository _authRepository;
  final AbstractUserStatusRepository _userStatusRepository;

  AuthUsecase(this._authRepository, this._userStatusRepository);

  @override
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  @override
  User? get currentUser => _authRepository.currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    if (user != null) {
      final userStatus = await _userStatusRepository.getUserStatus(user);
      if (userStatus == null) {
        await _userStatusRepository.createUserStatus(user);
      }
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
