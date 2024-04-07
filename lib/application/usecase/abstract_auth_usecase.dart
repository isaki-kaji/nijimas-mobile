import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthUsecase {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  bool get isAnonymous;
  Future<void> signInWithGoogle({required void Function() onFailure});
  Future<void> signInAsGuest();
  Future<void> signOut();
}
