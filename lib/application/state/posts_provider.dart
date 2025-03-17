import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/post_repository_provider.dart';
import 'package:nijimas/core/provider/repository/post_search_repository_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<Post>> build(PostQuery query) {
    return Future.value([]);
  }

  Future<List<Post>> fetchPosts(String? referenceId) async {
    try {
      final postRepository = ref.read(postRepositoryProvider);
      final postSearchRepository = ref.read(postSearchRepositoryProvider);
      List<Post> posts;
      switch (query.type) {
        // case PostQueryType.own:
        //   results = await postRepository.getOwnPosts();
        case PostQueryType.timeline:
          posts = await postRepository.getTimelinePosts(referenceId);
        // case PostQueryType.uid:
        //   results = await postSearchRepository.getPostsByUid(query.params);
        // case PostQueryType.mainCategory:
        //   results =
        //       await postSearchRepository.getPostsByMainCategory(query.params);
        // case PostQueryType.subCategory:
        //   results =
        //       await postSearchRepository.getPostsBySubCategory(query.params);
        // case PostQueryType.mainCategoryAndSubCategory:
        //   results = await postSearchRepository
        //       .getPostsByMainCategoryAndSubCategory(query.params);
        // case PostQueryType.ownAndMainCategory:
        //   results =
        //       await postRepository.getOwnPostsByMainCategory(query.params);
        // case PostQueryType.ownAndSubCategory:
        //   results = await postRepository.getOwnPostsBySubCategory(query.params);
        default:
          posts = await postRepository.getOwnPosts();
      }

      return posts;
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
