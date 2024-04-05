import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractUserStatusUseCase {
  Future<bool> isFirstSignIn(User user);
}
