import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_user_usecase.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

final userUsecaseProvider = Provider<UserUsecase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final userStatusRepository = ref.read(userStatusRepositoryProvider);
  final authRepository = ref.read(authRepositoryProvider);
  return UserUsecase(userRepository, userStatusRepository, authRepository);
});

class UserUsecase extends AbstractUserUsecase {
  final AbstractUserRepository _userRepository;
  final AbstractUserStatusRepository _userStatusRepository;
  final AbstractAuthRepository _authRepository;
  UserUsecase(
      this._userRepository, this._userStatusRepository, this._authRepository);

  @override
  Future<void> createUser(
      {required CreateUserRequest request,
      required void Function() onSuccess,
      required void Function() onFailure}) async {
    try {
      //await _userRepository.createUser(request);
      await _userStatusRepository
          .toggleIsFirstSignIn(_authRepository.currentUser!);
      onSuccess();
    } catch (e) {
      onFailure();
    }
  }
}
