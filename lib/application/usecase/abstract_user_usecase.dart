import 'package:nijimas/domain/model/user_profile.dart';
import 'package:nijimas/domain/request/create_user_request.dart';

abstract class AbstractUserUsecase {
  Future<void> createUser({
    required CreateUserRequest request,
    required void Function() onSuccess,
    required void Function() onFailure,
    required void Function() onUserAlreadyExists,
  });

  Future<UserProfile> getUser({required String uid});
}
