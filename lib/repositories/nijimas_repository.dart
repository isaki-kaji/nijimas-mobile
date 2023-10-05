import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/firebase_constants.dart';
import 'package:nijimas/core/failure.dart';
import 'package:nijimas/core/providers/firebase_providers.dart';
import 'package:nijimas/core/type_defs.dart';
import 'package:nijimas/models/post_model/nijimas_post_model.dart';

final nijimasRepositoryProvider = Provider<NijimasRepository>((ref) {
  return NijimasRepository(firestore: ref.watch(firestoreProvider));
});

class NijimasRepository {
  final FirebaseFirestore _firestore;
  NijimasRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  FutureVoid doNijimas(NijimasPost post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
