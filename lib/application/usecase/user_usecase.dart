import 'package:nijimas/application/usecase/abstract_user_usecase.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';

class UserUsecase extends AbstractUserUsecase {
  final AbstractUserRepository _userRepository;
  final AbstractUserStatusRepository _userStatusRepository;
  final AbstractAuthRepository _authRepository;
  UserUsecase(
      {required AbstractUserRepository userRepository,
      required AbstractUserStatusRepository userStatusRepository,
      required AbstractAuthRepository authRepository})
      : _userRepository = userRepository,
        _userStatusRepository = userStatusRepository,
        _authRepository = authRepository;

  @override
  Future<void> createUser(
      {required CreateUserRequest request,
      required void Function() onSuccess,
      required void Function() onFailure}) async {
    try {
      await _userRepository.createUser(request);
      await _userStatusRepository
          .toggleIsFirstSignIn(_authRepository.currentUser!);
      onSuccess();
    } catch (e) {
      onFailure();
    }
  }
}
