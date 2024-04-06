import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_user_usecase.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';
import 'package:nijimas/repository/user_repository.dart';

final userUsecaseProvider = Provider<UserUsecase>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UserUsecase(userRepository);
});

class UserUsecase extends AbstractUserUsecase {
  final AbstractUserRepository _userRepository;
  UserUsecase(this._userRepository);

  @override
  Future<void> createUser(CreateUserRequest request) async {
    await _userRepository.createUser(request);
  }
}
