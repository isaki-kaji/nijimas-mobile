import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/model/post.dart';

abstract class AbstractPostUsecase {
  Future<void> createPost({
    required PostFormData formData,
    required void Function() onSuccess,
    required void Function() onFailure,
  });

  Future<List<Post>> getOwnPosts();
  Future<List<Post>> getPostsByQuery(PostQuery query);
}
