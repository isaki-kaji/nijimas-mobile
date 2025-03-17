import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/post_repository_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/provider/repository/post_search_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_provider.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  PagingState<String, Post> build(PostQuery query) {
    return PagingState<String, Post>();
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final postRepository = ref.read(postRepositoryProvider);
      final postSearchRepository = ref.read(postSearchRepositoryProvider);
      final newKey = state.keys?.last;
      List<Post> newPosts;
      switch (query.type) {
        case PostQueryType.own:
          newPosts = await postRepository.getOwnPosts(newKey);
        case PostQueryType.timeline:
          newPosts = await postRepository.getTimelinePosts(newKey);
        case PostQueryType.uid:
          newPosts =
              await postSearchRepository.getPostsByUid(query.params, newKey);
        case PostQueryType.subCategory:
          newPosts = await postSearchRepository.getPostsBySubCategory(
              query.params, newKey);
        default:
          newPosts = await postRepository.getOwnPosts(newKey);
      }

      final isLastPage = newPosts.isEmpty;

      state = state.copyWith(
        pages: [...?state.pages, if (!isLastPage) newPosts],
        keys: [
          ...?state.keys,
          if (!isLastPage) newPosts.last.postId,
        ],
        hasNextPage: !isLastPage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e,
        isLoading: false,
      );
    }
  }

  void toggleFavorite(String postId, bool isFavorite) {
    final updatedPages = state.pages
        ?.map((page) => page
            .map((post) => post.postId == postId
                ? post.copyWith(isFavorite: isFavorite)
                : post)
            .toList())
        .toList();

    state = state.copyWith(pages: updatedPages);
  }
}
