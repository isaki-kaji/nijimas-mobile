import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthUsecase {
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
