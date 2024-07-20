import 'package:nijimas/application/formdata/user_form_data.dart';
import 'package:nijimas/core/model/user_profile.dart';
import 'package:nijimas/core/request/create_user_request.dart';

abstract class AbstractUserUsecase {
  Future<void> createUser({
    required CreateUserRequest request,
    required void Function() onSuccess,
    required void Function() onFailure,
    required void Function() onUserAlreadyExists,
  });

  Future<UserProfile> getUser({required String uid});

  Future<void> updateUser(
      {required UserFormData formData,
      required void Function() onSuccess,
      required void Function() onFailure});
}
