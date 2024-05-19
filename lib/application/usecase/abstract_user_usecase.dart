import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';

abstract class AbstractUserUsecase {
  Future<void> createUser({
    required CreateUserRequest request,
    required void Function() onSuccess,
    required void Function() onFailure,
    required void Function() onUserAlreadyExists,
  });

  Future<UserResponse> getUser({required String uid});
}
