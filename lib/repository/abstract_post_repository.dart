import 'package:nijimas/domain/request/create_post_request.dart';

abstract class AbstractPostRepository {
  Future<void> createPost(CreatePostRequest request);
}
