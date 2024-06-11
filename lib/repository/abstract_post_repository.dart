import 'package:nijimas/domain/request/create_post_request.dart';
import 'package:nijimas/domain/response/post_response.dart';

abstract class AbstractPostRepository {
  Future<void> createPost(CreatePostRequest request);
  Future<List<PostResponse>> getPostsByUid({required String uid});
  Future<List<PostResponse>> getPostsByMainCategory(
      {required String mainCategory});
}
