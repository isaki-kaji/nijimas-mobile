import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/formdata/user_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/image_usecase.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/core/request/create_user_request.dart';
import 'package:nijimas/core/request/update_user_request.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';

class UserUsecase {
  final UserRepository _userRepository;
  final UserStatusRepository _userStatusRepository;
  final AuthRepository _authRepository;
  final ImageUsecase _imageUsecase;
  final Ref _ref;
  UserUsecase(
      {required UserRepository userRepository,
      required UserStatusRepository userStatusRepository,
      required AuthRepository authRepository,
      required ImageUsecase imageUsecase,
      required Ref ref})
      : _userRepository = userRepository,
        _userStatusRepository = userStatusRepository,
        _authRepository = authRepository,
        _imageUsecase = imageUsecase,
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

  Future<UserDetail> getUser({required String uid}) async {
    try {
      return await _userRepository.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(
      {required UserFormData formData,
      required String? profileImageUrl,
      required int version,
      required void Function() onSuccess,
      required void Function() onFailure}) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      final uid = _ref.read(authStateProvider).valueOrNull!.uid;
      if (formData.profileImage != null) {
        profileImageUrl =
            await _imageUsecase.uploadProfileImage(formData.profileImage!, uid);
      }
      final request = UpdateUserRequest(
        uid: uid,
        username: formData.username,
        selfIntro: formData.selfIntro,
        profileImageUrl: profileImageUrl,
        version: version,
      );
      await _userRepository.updateUser(request);
      onSuccess();
    } catch (e) {
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }
}
