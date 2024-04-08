import 'package:firebase_auth/firebase_auth.dart';

abstract class AbstractAuthUsecase {
  Stream<User?> get authStateChanges;
  Future<void> signInWithGoogle({required void Function() onFailure});
  Future<void> signInAsGuest();
  Future<void> signOut();
}
