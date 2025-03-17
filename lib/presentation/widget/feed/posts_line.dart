import 'package:flutter/material.dart';
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
    final state = ref.watch(postsNotifierProvider(query));

    return PagedListView<String, Post>(
      state: state,
      fetchNextPage: () =>
          ref.read(postsNotifierProvider(query).notifier).fetchNextPage(),
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
