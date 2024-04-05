import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<User?> signInWithGoogle();
  Future<User?> signInAsGuest();
  Future<void> signOut();
}
