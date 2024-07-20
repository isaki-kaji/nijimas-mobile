import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/formdata/user_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/abstract_image_usecase.dart';
import 'package:nijimas/application/usecase/abstract_user_usecase.dart';
import 'package:nijimas/core/util/exception.dart';
import 'package:nijimas/core/model/user_profile.dart';
import 'package:nijimas/core/request/create_user_request.dart';
import 'package:nijimas/core/request/update_user_request.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/abstract_user_repository.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';

class UserUsecase extends AbstractUserUsecase {
  final AbstractUserRepository _userRepository;
  final AbstractUserStatusRepository _userStatusRepository;
  final AbstractAuthRepository _authRepository;
  final AbstractImageUsecase _imageUsecase;
  final Ref _ref;
  UserUsecase(
      {required AbstractUserRepository userRepository,
      required AbstractUserStatusRepository userStatusRepository,
      required AbstractAuthRepository authRepository,
      required AbstractImageUsecase imageUsecase,
      required Ref ref})
      : _userRepository = userRepository,
        _userStatusRepository = userStatusRepository,
        _authRepository = authRepository,
        _imageUsecase = imageUsecase,
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

  @override
  Future<void> updateUser(
      {required UserFormData formData,
      required void Function() onSuccess,
      required void Function() onFailure}) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      final uid = _ref.read(authStateProvider).valueOrNull!.uid;
      String? profileImageUrl;
      if (formData.profileImage != null) {
        profileImageUrl =
            await _imageUsecase.uploadProfileImage(formData.profileImage!, uid);
      }
      final request = UpdateUserRequest(
        uid: uid,
        username: formData.username,
        selfIntro: formData.selfIntro,
        profileImageUrl: profileImageUrl,
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
