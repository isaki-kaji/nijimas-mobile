import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/web.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/abstract_image_usecase.dart';
import 'package:nijimas/application/usecase/abstract_post_usecase.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/domain/model/post.dart';
import 'package:nijimas/domain/request/create_post_request.dart';
import 'package:nijimas/repository/abstract_post_repository.dart';
import 'package:uuid/uuid.dart';

class PostUsecase extends AbstractPostUsecase {
  final AbstractPostRepository _postRepository;
  final AbstractImageUsecase _imageUsecase;
  final Logger _logger;
  final Ref _ref;
  PostUsecase(
      {required AbstractPostRepository postRepository,
      required AbstractImageUsecase imageUsecase,
      required Logger logger,
      required Ref ref})
      : _postRepository = postRepository,
        _imageUsecase = imageUsecase,
        _logger = logger,
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

      final int expense;
      if (formData.expense != null && formData.expense!.isNotEmpty) {
        if (_isNumeric(formData.expense!)) {
          expense = int.parse(formData.expense!);
        } else {
          throw const FormatException('Invalid number format');
        }
      } else {
        expense = 0;
      }

      //postTextからlocationを取得する処理を追加

      final photoUrl =
          await _imageUsecase.uploadPostImages(formData.images, '$uid/$postId');

      final request = CreatePostRequest(
          postId: postId,
          uid: uid,
          mainCategory: formData.mainCategory,
          subCategory1: subCategory1,
          subCategory2: subCategory2,
          postText: formData.postText,
          photoUrl: photoUrl,
          expense: expense,
          location: null,
          publicTypeNo: formData.publicTypeNo);

      await _postRepository.createPost(request);
      onSuccess();
    } catch (e) {
      _logger.e('Failed to create post: $e');
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  @override
  Future<List<Post>> getPostsByQuery(PostQuery query) async {
    try {
      final params = query.params;
      switch (query.type) {
        case PostQueryType.uid:
          return await _postRepository.getPostsByUid(
              uid: params[PostQueryKey.uid]);
        case PostQueryType.mainCategory:
          return await _postRepository.getPostsByMainCategory(
              mainCategory: params[PostQueryKey.mainCategory]);
        default:
          throw Exception('Query type not found');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

bool _isNumeric(String str) {
  final number = num.tryParse(str);
  return number != null;
}
