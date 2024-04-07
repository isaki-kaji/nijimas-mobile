import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_user_status_usecase.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

final userStatusUseCaseProvider = Provider<UserStatusUseCase>((ref) {
  final userStatusRepository = ref.read(userStatusRepositoryProvider);
  return UserStatusUseCase(userStatusRepository);
});

class UserStatusUseCase extends AbstractUserStatusUsecase {
  final AbstractUserStatusRepository _userStatusRepository;

  UserStatusUseCase(this._userStatusRepository);

  @override
  Future<bool> isFirstSignIn(User user) async {
    final userStatus = await _userStatusRepository.getUserStatus(user);
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
