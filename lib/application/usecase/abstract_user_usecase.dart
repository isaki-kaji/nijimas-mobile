import 'package:nijimas/domain/request/create_user_request.dart';

abstract class AbstractUserUsecase {
  Future<void> createUser({
    required CreateUserRequest request,
    required void Function() onSuccess,
    required void Function() onFailure,
  });
}