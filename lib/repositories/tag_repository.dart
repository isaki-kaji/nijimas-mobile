import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/firebase_constants.dart';
import 'package:nijimas/core/failure.dart';
import 'package:nijimas/core/providers/firebase_providers.dart';
import 'package:nijimas/core/type_defs.dart';

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  return TagRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class TagRepository {
  final FirebaseFirestore _firestore;
  TagRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _tags =>
      _firestore.collection(FirebaseConstants.tagsCollection);

  FutureVoid addTag(String tag) async {
    try {
      return right(_tags.doc(tag).set({'tagId': tag}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<String>> searchTag(String query) {
    return _tags
        .where(
          "tagId",
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<String> tags = [];
      for (var tag in event.docs) {
        tags.add(tag.id); // tagIdだけをtagsに格納する
      }
      return tags;
    });
  }
}
