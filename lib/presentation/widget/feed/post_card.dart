import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/domain/response/post_response.dart';

class PostCard extends HookConsumerWidget {
  final PostResponse postResponse;
  const PostCard({super.key, required this.postResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(postResponse.postText ?? "なし"),
          Text(postResponse.mainCategory),
          Text(postResponse.subCategory ?? ''),
          Text(postResponse.subCategory2 ?? ''),
          Text(postResponse.expense.toString()),
          Text(postResponse.location ?? "場所不明"),
        ],
      ),
    );
  }
}
