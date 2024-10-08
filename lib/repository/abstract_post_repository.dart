import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/create_post_request.dart';

abstract class AbstractPostRepository {
  Future<void> createPost(CreatePostRequest request);
  Future<List<Post>> getOwnPosts();
  // Future<List<Post>> getPostsByUid({required String uid});
  Future<List<Post>> getPostsByMainCategory({required String mainCategory});
}
