import 'package:nijimas/domain/model/auth_user.dart';

abstract class AbstractAuthUsecase {
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
}
