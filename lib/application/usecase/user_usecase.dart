import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

class UserUsecase {
  final UserRepository _userRepository;
  final UserStatusRepository _userStatusRepository;
  final AuthRepository _authRepository;
  final Ref _ref;
  UserUsecase(
      {required UserRepository userRepository,
      required UserStatusRepository userStatusRepository,
      required AuthRepository authRepository,
      required Ref ref})
      : _userRepository = userRepository,
        _userStatusRepository = userStatusRepository,
        _authRepository = authRepository,
        _ref = ref;

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

  Future<UserResponse> getUser({required String uid}) async {
    try {
      return await _userRepository.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }
}
