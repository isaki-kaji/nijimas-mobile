import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';

abstract class AbstractUserRepository {
  Future<void> createUser(CreateUserRequest request);
  Future<UserResponse> getUser(String uid);
}
