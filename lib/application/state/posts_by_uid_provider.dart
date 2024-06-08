import 'package:nijimas/core/provider/usecase/favorite_usecase_provider.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/domain/request/toggle_favorite_request.dart';
import 'package:nijimas/domain/response/post_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_by_uid_provider.g.dart';

@riverpod
class PostsByUidNotifier extends _$PostsByUidNotifier {
  @override
  Future<List<PostResponse>> build(String uid) async {
    try {
      final postUsecase = ref.read(postUsecaseProvider);
      return await postUsecase.getPostsByUid(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(ToggleFavoriteRequest request) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedPosts = currentState.map((post) {
      if (post.postId == request.postId) {
        return post.copyWith(isFavorite: !post.isFavorite);
      }
      return post;
    }).toList();
    state = AsyncValue.data(updatedPosts);

    try {
      await ref.read(favoriteUsecaseProvider).toggleFavorite(request);
    } catch (e) {
      // 失敗した場合のロールバック
      state = AsyncValue.data(currentState);
      rethrow;
    }
  }
}
