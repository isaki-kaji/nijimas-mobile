import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/post_repository_provider.dart';
import 'package:nijimas/core/provider/repository/post_search_repository_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<Post>> build(PostQuery query) async {
    try {
      final postRepository = ref.read(postRepositoryProvider);
      final postSearchRepository = ref.read(postSearchRepositoryProvider);
      switch (query.type) {
        case PostQueryType.own:
          return await postRepository.getOwnPosts();
        case PostQueryType.timeline:
          return await postRepository.getTimelinePosts();
        case PostQueryType.uid:
          return await postSearchRepository.getPostsByUid(query.params);
        case PostQueryType.mainCategory:
          return await postSearchRepository
              .getPostsByMainCategory(query.params);
        case PostQueryType.subCategory:
          return await postSearchRepository.getPostsBySubCategory(query.params);
        case PostQueryType.mainCategoryAndSubCategory:
          return await postSearchRepository
              .getPostsByMainCategoryAndSubCategory(query.params);
        case PostQueryType.ownAndMainCategory:
          return await postRepository.getOwnPostsByMainCategory(query.params);
        case PostQueryType.ownAndSubCategory:
          return await postRepository.getOwnPostsBySubCategory(query.params);
        default:
          return await postRepository.getOwnPosts();
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFavorite(String postId, bool isFavorite) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedPosts = currentState.map((post) {
      if (post.postId == postId) {
        return post.copyWith(isFavorite: isFavorite);
      }
      return post;
    }).toList();
    state = AsyncValue.data(updatedPosts);
  }
}
