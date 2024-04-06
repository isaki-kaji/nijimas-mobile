import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractUserStatusUsecase {
  Future<bool> isFirstSignIn(User user);
}
