import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/post_repository_provider.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/provider/repository/post_search_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_map_provider.g.dart';

@riverpod
class PostsMapNotifier extends _$PostsMapNotifier {
  @override
  Map<PostQuery, PagingState<String, Post>> build() => {};

  Future<void> fetchNextPage(PostQuery query) async {
    final current = state[query] ?? PagingState<String, Post>();

    if (current.isLoading || !current.hasNextPage) return;

    state = {
      ...state,
      query: current.copyWith(isLoading: true, error: null),
    };

    try {
      final newKey = current.keys?.last;
      final repo = _getRepository(query);
      final newPosts = await repo(query.params, newKey);

      final isLastPage = newPosts.isEmpty;

      state = {
        ...state,
        query: current.copyWith(
          pages: [...?current.pages, if (!isLastPage) newPosts],
          keys: [...?current.keys, if (!isLastPage) newPosts.last.postId],
          hasNextPage: !isLastPage,
          isLoading: false,
        ),
      };
    } catch (e) {
      state = {
        ...state,
        query: current.copyWith(error: e, isLoading: false),
      };
    }
  }

  void toggleFavorite(String postId, PostQuery query) {
    // 全てのPostQueryを対象にする
    final updatedState = state.map((key, pagingState) {
      // 該当する投稿を更新
      final updatedPages = pagingState.pages
          ?.map((page) => page
              .map((post) => post.postId == postId
                  ? post.copyWith(isFavorite: !post.isFavorite)
                  : post)
              .toList())
          .toList();

      return MapEntry(key, pagingState.copyWith(pages: updatedPages));
    });

    // 状態を更新
    state = updatedState;

    // 現在のPostQueryがfavoriteの場合は再取得を行わない
    if (query.type == PostQueryType.favorite) {
      return;
    }

    invalidateFavoriteQuery();
  }

  /// キャッシュ削除
  void invalidateQuery(PostQuery query) {
    final newState = {...state}..remove(query);
    state = newState;
  }

  void invalidateFavoriteQuery() {
    // favoriteのPostQueryをキーごと削除
    final newState = {...state};
    newState.removeWhere((key, _) => key.type == PostQueryType.favorite);
    state = newState;
  }

  void resetAndFetch(PostQuery query) {
    // キャッシュをリセット
    state = {};

    // 指定されたPostQueryに基づいて再取得
    fetchNextPage(query);
  }

  Future<List<Post>> Function(Map<PostQueryKey, String>, String?)
      _getRepository(PostQuery query) {
    final postRepo = ref.read(postRepositoryProvider);
    final searchRepo = ref.read(postSearchRepositoryProvider);

    switch (query.type) {
      case PostQueryType.own:
        return (_, key) => postRepo.getOwnPosts(key);
      case PostQueryType.timeline:
        return (_, key) => postRepo.getTimelinePosts(key);
      case PostQueryType.favorite:
        return (_, key) => postRepo.getFavoritePosts(key);
      case PostQueryType.uid:
        return (params, key) => searchRepo.getPostsByUid(params, key);
      case PostQueryType.subCategory:
        return (params, key) => searchRepo.getPostsBySubCategory(params, key);
      default:
        return (_, key) => postRepo.getOwnPosts(key); // fallback
    }
  }
}
