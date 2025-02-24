import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class PostsLine extends ConsumerWidget {
  const PostsLine(
      {super.key,
      required this.query,
      required this.canTap,
      required this.canEdit});

  final PostQuery query;
  final bool canTap;
  final bool canEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return ref.watch(postsNotifierProvider(query)).when(
      data: (data) {
        return data.isEmpty
            ? Center(
                child: Text(l10n.noPosts, style: MyTextStyles.body14),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return PostCard(
                    post: post,
                    query: query,
                    canTap: canTap,
                    canEdit: canEdit,
                  );
                },
              );
      },
      error: (error, _) {
        return Text(error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
