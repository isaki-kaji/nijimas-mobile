import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/firebase_constants.dart';
import 'package:nijimas/core/failure.dart';
import 'package:nijimas/core/providers/firebase_providers.dart';
import 'package:nijimas/core/type_defs.dart';
import 'package:nijimas/models/post_model.dart';
import 'package:nijimas/models/user_model/user_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.postId).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchUserFollowingPosts(UserModel user) {
    List<String> followingList = [...user.following, user.uid];
    return _posts
        .where("uid", whereIn: followingList.map((e) => e).toList())
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<Post>> fetchPaginationUserFollowingPosts(UserModel user,
      {DocumentSnapshot? lastDocument}) {
    List<String> followingList = [...user.following, user.uid];
    var query = FirebaseFirestore.instance
        .collection('posts')
        .where("uid", whereIn: followingList)
        .orderBy("createdAt", descending: true)
        .limit(20);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList());
  }

  void favoritePost(Post post, String uid) async {
    if (post.favoriteUids.contains(uid)) {
      _posts.doc(post.postId).update({
        "favoriteUids": FieldValue.arrayRemove([uid]),
      });
    } else {
      _posts.doc(post.postId).update({
        "favoriteUids": FieldValue.arrayUnion([uid]),
      });
    }
  }

  FutureVoid deletePost(Post post) async {
    try {
      return right(_posts.doc(post.postId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
