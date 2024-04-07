import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constant/firebase_constant.dart';
import 'package:nijimas/core/provider/firebase_provider.dart';
import 'package:nijimas/domain/model/user_status.dart';
import 'package:nijimas/repository/abstract_user_status_repository.dart';

final userStatusRepositoryProvider =
    Provider<AbstractUserStatusRepository>((ref) {
  return UserStatusRepository(firestore: ref.read(firestoreProvider));
});

class UserStatusRepository extends AbstractUserStatusRepository {
  final FirebaseFirestore _firestore;

  UserStatusRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _userStatus =>
      _firestore.collection(FirebaseConstants.userStatusCollection);

  @override
  Future<UserStatus?> getUserStatus(User user) async {
    final snapshot = await _userStatus.doc(user.uid).get();
    if (!snapshot.exists) {
      return null;
    }
    final data = snapshot.data() as Map<String, dynamic>;
    return UserStatus.fromJson(data);
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
      return;
    }
    await _userStatus.doc(user.uid).update({
      'isFirstSignIn': false,
    });
  }
}
