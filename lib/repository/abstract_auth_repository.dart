import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthRepository {
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<User?> signInAsGuest();
  Future<void> registerUserStatus(User user);
  Future<void> signOut();
}
