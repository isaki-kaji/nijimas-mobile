import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/usecase/abstract_user_status_usecase.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

final userStatusUseCaseProvider = Provider<UserStatusUseCase>((ref) {
  final userStatusRepository = ref.read(userStatusRepositoryProvider);
  return UserStatusUseCase(userStatusRepository, ref);
});

class UserStatusUseCase extends AbstractUserStatusUsecase {
  final AbstractUserStatusRepository _userStatusRepository;
  final Ref _ref;

  UserStatusUseCase(this._userStatusRepository, this._ref);

  @override
  Future<bool> isFirstSignIn() async {
    final asyncValue = _ref.read(authStateProvider);
    final user = asyncValue.value;
    final userStatus = await _userStatusRepository.getUserStatus(user!);
    if (userStatus == null) {
      return true;
    }
    return userStatus.isFirstSignIn;
  }

  @override
  Future<void> toggleIsFirstSignIn(User user) async {
    await _userStatusRepository.toggleIsFirstSignIn(user);
  }
}
