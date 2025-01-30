import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(postQueryNotifierProvider);
    return PostsLine(query: query, canTap: true);
  }
}
