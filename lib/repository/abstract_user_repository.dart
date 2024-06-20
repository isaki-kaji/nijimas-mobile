import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/request/update_user_request.dart';

abstract class AbstractUserRepository {
  Future<void> createUser(CreateUserRequest request);
  Future<dynamic> getUser(String uid);
  Future<void> updateUser(UpdateUserRequest request);
}
