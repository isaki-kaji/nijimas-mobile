import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/firebase_constants.dart';
import 'package:nijimas/core/failure.dart';
import 'package:nijimas/core/providers/firebase_providers.dart';
import 'package:nijimas/core/type_defs.dart';
import 'package:nijimas/models/nijimas_model.dart';

final nijimasRepositoryProvider = Provider<NijimasRepository>((ref) {
  return NijimasRepository(firestore: ref.watch(firestoreProvider));
});

class NijimasRepository {
  final FirebaseFirestore _firestore;
  NijimasRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _nijimas =>
      _firestore.collection(FirebaseConstants.nijimasCollection);

  FutureVoid doNijimas(Nijimas nijimas) async {
    try {
      return right(_nijimas.doc(nijimas.nijimasId).set(nijimas.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid storePhotoInNijimas(String nijimasId, String photoId) async {
    try {
      return right(_nijimas.doc(nijimasId).update({
        'photos': FieldValue.arrayUnion([photoId])
      }));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Nijimas>> getCurrentNijimas(String section, String uid) {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final twentyFourHoursAgo = now - (24 * 60 * 60 * 1000);
    return _nijimas
        .where('section', isEqualTo: section)
        .where('uid', isEqualTo: uid)
        .where('createdAt', isGreaterThanOrEqualTo: twentyFourHoursAgo)
        .snapshots()
        .map((snapshot) {
      final docs = snapshot.docs;
      if (docs.isNotEmpty) {
        return docs
            .map((doc) => Nijimas.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    });
  }

  Stream<List<Nijimas>> getTodayNijimas(String uid) {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final twentyFourHoursAgo = now - (24 * 60 * 60 * 1000);
    return _nijimas
        .where('uid', isEqualTo: uid)
        .where('createdAt', isGreaterThanOrEqualTo: twentyFourHoursAgo)
        .snapshots()
        .map((snapshot) {
      final docs = snapshot.docs;
      if (docs.isNotEmpty) {
        return docs
            .map((doc) => Nijimas.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    });
  }
}
