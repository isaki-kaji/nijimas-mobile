import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/web.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Logger _logger;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required Logger logger,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _logger = logger;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  bool get isAnonymous => _firebaseAuth.currentUser?.isAnonymous ?? true;

  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("Failed to sign in with Google");
    }

    final googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw Exception("Failed to sign in with Google: token missing");
    }
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user;
  }

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (appleCredential.identityToken == null) {
        _logger.w("Failed to sign in with Apple: token missing");
        throw Exception("Failed to sign in with Apple: token missing");
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      return userCredential.user;
    } catch (e) {
      _logger.e("Failed to sign in with Apple");
      throw Exception("Failed to sign in with Apple: $e");
    }
  }

  Future<User?> signInAsGuest() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<void> signOut() async {
    final user = _firebaseAuth.currentUser;
    if (user?.isAnonymous ?? true) {
      await user?.delete();
    }
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.signOut();
    }
    await _firebaseAuth.signOut();
  }
}
