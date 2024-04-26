import 'package:nijimas/application/formdata/post_form_data.dart';

abstract class AbstractPostUsecase {
  Future<void> createPost({
    required PostFormData formData,
    required void Function() onSuccess,
    required void Function() onFailure,
  });
}
