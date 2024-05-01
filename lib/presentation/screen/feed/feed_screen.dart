import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
        child: Column(
      children: [Text("Feed Screen"), PostCard()],
    ));
  }
}
