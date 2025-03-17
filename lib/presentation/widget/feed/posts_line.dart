import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class PostsLine extends HookConsumerWidget {
  const PostsLine({
    super.key,
    required this.query,
    required this.canTap,
    required this.canEdit,
  });

  final PostQuery query;
  final bool canTap;
  final bool canEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState(PagingState<String, Post>());

    Future<void> fetchNextPage() async {
      if (state.value.isLoading) return;

      state.value = state.value.copyWith(isLoading: true, error: null);

      try {
        final newKey = state.value.keys?.last;
        final newPosts = await ref
            .read(postsNotifierProvider(query).notifier)
            .fetchPosts(newKey);

        final isLastPage = newPosts.isEmpty;

        state.value = state.value.copyWith(
          pages: [...?state.value.pages, if (!isLastPage) newPosts],
          keys: [
            ...?state.value.keys,
            if (!isLastPage) newPosts.last.postId,
          ],
          hasNextPage: !isLastPage,
          isLoading: false,
        );
      } catch (e) {
        state.value = state.value.copyWith(
          error: e,
          isLoading: false,
        );
      }
    }

    return PagedListView<String, Post>(
      state: state.value,
      fetchNextPage: fetchNextPage,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => PostCard(
          query: query,
          post: item,
          canTap: canTap,
          canEdit: canEdit,
        ),
      ),
    );
  }
}
