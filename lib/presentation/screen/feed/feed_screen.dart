import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class FeedScreen extends HookConsumerWidget {
  final PostQuery query;
  const FeedScreen({super.key, required this.query});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postsNotifierProvider(query)).when(data: (data) {
      return SingleChildScrollView(
        child: Column(
          children: data
              .map((post) => PostCard(post: post, query: query))
              .toList(growable: false),
        ),
      );
    }, error: (error, _) {
      return Text(error.toString());
    }, loading: () {
      return const Loader();
    });
  }
}
