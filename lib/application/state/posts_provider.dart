import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/usecase/favorite_usecase_provider.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@Riverpod(keepAlive: true)
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<Post>> build(PostQuery query) async {
    try {
      final postUsecase = ref.read(postUsecaseProvider);
      if (query.type == PostQueryType.own) {
        return await postUsecase.getOwnPosts();
      }
      return // await postUsecase.getPostsByQuery(query);
          await postUsecase.getOwnPosts();
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
