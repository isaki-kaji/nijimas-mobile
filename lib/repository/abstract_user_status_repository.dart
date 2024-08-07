import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/core/model/user_status.dart';

abstract class AbstractUserStatusRepository {
  Future<UserStatus?> getUserStatus(User user);
  Future<void> createUserStatus(User user);
  Future<void> toggleIsFirstSignIn(User user);
}
