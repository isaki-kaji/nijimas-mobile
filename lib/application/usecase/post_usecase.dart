import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/abstract_post_usecase.dart';
import 'package:nijimas/domain/request/create_post_request.dart';
import 'package:nijimas/repository/abstract_post_repository.dart';
import 'package:uuid/uuid.dart';

class PostUsecase extends AbstractPostUsecase {
  final AbstractPostRepository _postRepository;
  final Ref _ref;
  PostUsecase(
      {required AbstractPostRepository postRepository, required Ref ref})
      : _postRepository = postRepository,
        _ref = ref;

  @override
  Future<void> createPost({
    required PostFormData formData,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      const uuid = Uuid();
      final postId = uuid.v4();
      String? subCategory1;
      String? subCategory2;
      final uid = _ref.read(authStateProvider).valueOrNull!.uid;

      if (formData.subCategories.length == 1) {
        subCategory1 = formData.subCategories[0];
        subCategory2 = null;
      }
      if (formData.subCategories.length == 2) {
        subCategory1 = formData.subCategories[0];
        subCategory2 = formData.subCategories[1];
      }

      final int? expense =
          formData.expense != null ? int.parse(formData.expense!) : null;

      //postTextからlocationを取得する処理を追加
      //imagesをS3にアップロードし、そのURLを取得する処理を追加

      final request = CreatePostRequest(
          postId: postId,
          uid: uid,
          mainCategory: formData.mainCategory,
          subCategory1: subCategory1,
          subCategory2: subCategory2,
          postText: formData.postText,
          expense: expense,
          location: null,
          publicTypeNo: formData.publicTypeNo);

      await _postRepository.createPost(request);
      onSuccess();
    } catch (e) {
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }
}