import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/web.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/image_usecase.dart';
import 'package:nijimas/core/request/create_post_request.dart';
import 'package:nijimas/core/request/update_post_request.dart';
import 'package:nijimas/repository/post_repository.dart';
import 'package:uuid/uuid.dart';

class PostUsecase {
  final PostRepository _postRepository;
  final ImageUsecase _imageUsecase;
  final Logger _logger;
  final Ref _ref;

  PostUsecase({
    required PostRepository postRepository,
    required ImageUsecase imageUsecase,
    required Logger logger,
    required Ref ref,
  })  : _postRepository = postRepository,
        _imageUsecase = imageUsecase,
        _logger = logger,
        _ref = ref;

  Future<void> createPost({
    required PostFormData formData,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) async {
    List<String> photoUrls = [];

    try {
      _ref.read(loadingProvider.notifier).setTrue();
      const uuid = Uuid();
      final postId = uuid.v7();
      final uid = _ref.read(authStateProvider).valueOrNull!.uid;

      // postTextからlocationを取得する処理を追加

      // **ここでエラーが発生すると、外側の catch に流れる**
      photoUrls =
          await _imageUsecase.uploadPostImages(formData.images, uid, postId);

      final expense = _parseExpense(formData.expense);

      final request = CreatePostRequest(
        postId: postId,
        uid: uid,
        mainCategory: formData.mainCategory,
        subCategories: formData.subCategories,
        postText: formData.postText,
        photoUrl: photoUrls.join(","),
        expense: expense,
        location: null,
        publicTypeNo: formData.publicTypeNo,
      );

      await _postRepository.createPost(request);
      onSuccess();
    } catch (e) {
      _logger.e('Failed to create post: $e');
      _deleteImagesOnError(photoUrls);
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  Future<void> updatePost({
    required String postId,
    required int version,
    required PostFormData formData,
    required List<String> currentPostUrls,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) async {
    List<String> photoUrls = [];

    try {
      _ref.read(loadingProvider.notifier).setTrue();
      final uid = _ref.read(authStateProvider).valueOrNull!.uid;

      photoUrls =
          await _imageUsecase.uploadPostImages(formData.images, uid, postId);

      final expense = _parseExpense(formData.expense);

      final request = UpdatePostRequest(
        uid: uid,
        mainCategory: formData.mainCategory,
        subCategories: formData.subCategories,
        postText: formData.postText,
        photoUrl: photoUrls.join(","),
        expense: expense,
        location: null,
        publicTypeNo: formData.publicTypeNo,
        version: version,
      );

      await _postRepository.updatePost(postId, request);

      // 更新成功したら、古い画像を削除
      _imageUsecase.deletePostImages(currentPostUrls);
      onSuccess();
    } catch (e) {
      _logger.e('Failed to update post: $e');
      _deleteImagesOnError(photoUrls);
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  Future<void> deletePost({
    required String postId,
    required List<String> photoUrls,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) async {
    try {
      _ref.read(loadingProvider.notifier).setTrue();
      await _postRepository.deletePost(postId);
      _imageUsecase.deletePostImages(photoUrls);
      onSuccess();
    } catch (e) {
      _logger.e('Failed to delete post: $e');
      onFailure();
    } finally {
      _ref.read(loadingProvider.notifier).setFalse();
    }
  }

  void _deleteImagesOnError(List<String> photoUrls) {
    if (photoUrls.isNotEmpty) {
      _imageUsecase.deletePostImages(photoUrls);
    }
  }
}

String _parseExpense(String? expense) {
  if (expense != null && expense.isNotEmpty) {
    if (_isNumeric(expense)) {
      return expense;
    } else {
      throw const FormatException('Invalid number format');
    }
  }
  return "0";
}

bool _isNumeric(String str) {
  return num.tryParse(str) != null;
}
