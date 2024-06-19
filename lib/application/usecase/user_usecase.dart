import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/abstract_user_usecase.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/domain/model/user_profile.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';

class UserUsecase extends AbstractUserUsecase {
  final AbstractUserRepository _userRepository;
  final AbstractUserStatusRepository _userStatusRepository;
  final AbstractAuthRepository _authRepository;
  final Ref _ref;
  UserUsecase(
      {required AbstractUserRepository userRepository,
      required AbstractUserStatusRepository userStatusRepository,
      required AbstractAuthRepository authRepository,
      required Ref ref})
      : _userRepository = userRepository,
        _userStatusRepository = userStatusRepository,
        _authRepository = authRepository,
        _ref = ref;

  @override
  Future<void> createUser(
      {required CreateUserRequest request,
      required void Function() onSuccess,
      required void Function() onFailure,
      required void Function() onUserAlreadyExists}) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      await _userRepository.createUser(request);
      await _userStatusRepository
          .toggleIsFirstSignIn(_authRepository.currentUser!);
      onSuccess();
    } on UserAlreadyExistsException {
      onUserAlreadyExists();
    } catch (e) {
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  @override
  Future<UserProfile> getUser({required String uid}) async {
    try {
      return await _userRepository.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }
}
