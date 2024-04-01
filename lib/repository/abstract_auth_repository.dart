import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthRepository {
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
