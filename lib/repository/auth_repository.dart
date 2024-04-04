import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/firebase_constant.dart';
import 'package:nijimas/core/provider/firebase_provider.dart';
import 'package:nijimas/core/provider/logger_provider.dart';
import 'package:nijimas/domain/model/user_status.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';

final authRepositoryProvider = Provider<AbstractAuthRepository>((ref) {
  return AuthRepository(
    firestore: ref.read(firestoreProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(googleSignInProvider),
    logger: ref.read(loggerProvider),
  );
});

final class AuthRepository extends AbstractAuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Logger _logger;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required Logger logger,
  })  : _firestore = firestore,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _logger = logger;

  CollectionReference get _userStatus =>
      _firestore.collection(FirebaseConstants.userStatusCollection);

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        return null;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      _logger.w('Failed to sign in with Google: $e');
      return null;
    }
  }

  @override
  Future<User?> signInAsGuest() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      _logger.w('Failed to sign in as a guest: $e');
      return null;
    }
  }

  @override
  Future<void> registerUserStatus(User user) async {
    try {
      final userStatusDoc = await _userStatus.doc(user.uid).get();
      if (userStatusDoc.exists) {
        Map<String, dynamic> userStatusData =
            userStatusDoc.data() as Map<String, dynamic>;
        if (userStatusData['isFirstSignIn'] == false) {
          return;
        }
      }
      final userStatus = UserStatus(
          uid: user.uid,
          isFirstSignIn: true,
          createdAt: user.metadata.creationTime!);

      await _userStatus.doc(user.uid).set(userStatus.toJson());
    } catch (e) {
      _logger.w('Failed to register user status: $e');
      throw Exception('Failed to register user status: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
