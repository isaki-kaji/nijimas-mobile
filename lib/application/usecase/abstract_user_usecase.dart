import 'package:nijimas/domain/request/create_user_request.dart';

abstract class AbstractUserUsecase {
  Future<void> createUser(CreateUserRequest request);
}
