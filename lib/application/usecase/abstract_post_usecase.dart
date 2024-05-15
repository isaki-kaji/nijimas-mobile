import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/domain/response/post_response.dart';

abstract class AbstractPostUsecase {
  Future<void> createPost({
    required PostFormData formData,
    required void Function() onSuccess,
    required void Function() onFailure,
  });

  Future<List<PostResponse>> getPostsByUid({required String uid});
}
