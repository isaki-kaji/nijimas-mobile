import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:nijimas/presentation/widget/home/post_search_dialog.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(postQueryNotifierProvider);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PostSearchDialog();
            },
          );
        },
      )),
      body: PostsLine(query: query, canTap: true, canEdit: false),
      floatingActionButton: const AddPostButton(),
    );
  }
}
