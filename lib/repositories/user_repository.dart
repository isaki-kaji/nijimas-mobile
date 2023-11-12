import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/firebase_constants.dart';
import 'package:nijimas/core/providers/firebase_providers.dart';
import 'package:nijimas/models/user_model/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(firestore: ref.watch(firestoreProvider));
});

class UserRepository {
  final FirebaseFirestore _firestore;
  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<UserModel> fetchUser(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  }
}
