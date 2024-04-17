import 'package:nijimas/domain/request/create_user_request.dart';

abstract class AbstractUserRepository {
  Future<void> createUser(CreateUserRequest request);
  Future<dynamic> getUser(String uid);
}
