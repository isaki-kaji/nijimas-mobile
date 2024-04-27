import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';
import 'package:nijimas/core/constant/firebase_constant.dart';
import 'package:nijimas/domain/model/user_status.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';

class UserStatusRepository extends AbstractUserStatusRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger;

  UserStatusRepository(
      {required FirebaseFirestore firestore, required Logger logger})
      : _firestore = firestore,
        _logger = logger;

  CollectionReference get _userStatus =>
      _firestore.collection(FirebaseConstants.userStatusCollection);

  @override
  Future<UserStatus?> getUserStatus(User user) async {
    try {
      final snapshot = await _userStatus.doc(user.uid).get();
      if (!snapshot.exists) {
        return null;
      }
      final data = snapshot.data() as Map<String, dynamic>;
      return UserStatus.fromJson(data);
    } on FirebaseException catch (e) {
      _logger.e(e);
      return null;
    }
  }

  @override
  Future<void> createUserStatus(User user) async {
    final userStatus = UserStatus(
        uid: user.uid,
        isFirstSignIn: true,
        createdAt: user.metadata.creationTime!);
    await _userStatus.doc(user.uid).set(userStatus.toJson());
  }

  @override
  Future<void> toggleIsFirstSignIn(User user) async {
    final userStatus = await getUserStatus(user);
    if (userStatus == null) {
      _logger.w('UserStatus is not found');
      throw Exception('UserStatus is not found');
    }
    await _userStatus.doc(user.uid).update({
      'isFirstSignIn': false,
    });
  }
}
