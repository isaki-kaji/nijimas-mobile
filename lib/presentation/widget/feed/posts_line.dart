import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/common/not_found_message.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';

class PostsLine extends HookConsumerWidget {
  const PostsLine({
    super.key,
    required this.query,
    required this.canEdit,
    this.isUserDetail = false,
  });

  final PostQuery query;
  final bool canEdit;
  final bool isUserDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);

    final state =
        ref.watch(postsMapNotifierProvider.select((map) => map[query]));
    final hasFetched = useState(false);

    useEffect(() {
      final isTimeline = query.type == PostQueryType.timeline;

      if (state != null) {
        hasFetched.value = true;
      }

      if (state == null && (!hasFetched.value || isTimeline)) {
        Future.microtask(() {
          ref.read(postsMapNotifierProvider.notifier).fetchNextPage(query);
          if (!isTimeline) {
            hasFetched.value = true;
          }
        });
      }
      return null;
    }, [state]);

    if (state == null) {
      return const Loader();
    }

    return PagedListView<String, Post>(
      state: state,
      fetchNextPage: () =>
          ref.read(postsMapNotifierProvider.notifier).fetchNextPage(query),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => PostCard(
          query: query,
          post: item,
          canEdit: canEdit,
          isUserDetail: isUserDetail,
        ),
        noItemsFoundIndicatorBuilder: (context) => NotFoundMessage(
          message: l10n.noPosts,
          icon: Icons.search_off,
        ),
        firstPageErrorIndicatorBuilder: (context) => ErrorMessage(
          message: l10n.errorOccurred,
        ),
        firstPageProgressIndicatorBuilder: (context) => const Loader(),
      ),
    );
  }
}
