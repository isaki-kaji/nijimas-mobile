import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/user_status_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository;
  final UserStatusRepository _userStatusRepository;
  final Ref _ref;

  AuthUsecase(
      {required AuthRepository authRepository,
      required UserStatusRepository userStatusRepository,
      required Ref ref})
      : _authRepository = authRepository,
        _userStatusRepository = userStatusRepository,
        _ref = ref;

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signInWithGoogle({required void Function() onFailure}) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      final user = await _authRepository.signInWithGoogle();
      if (user == null) {
        onFailure();
      }
      final userStatus = await _ref.read(currentUserStatusProvider.future);
      if (userStatus == null) {
        await _userStatusRepository.createUserStatus(user!);
        final currentUserStatus =
            await _userStatusRepository.getUserStatus(user);
        _ref.read(currentUserStatusProvider.notifier).set(currentUserStatus!);
      }
    } catch (e) {
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  Future<void> signInAsGuest() async {
    _ref.read(loadingProvider.notifier).setTrue();
    await _authRepository.signInAsGuest();
    _ref.read(loadingProvider.notifier).setFalse();
  }

  Future<void> signOut() async {
    return await _authRepository.signOut();
  }
}
