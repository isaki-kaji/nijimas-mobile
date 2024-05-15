import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/posts_by_uid_response.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).valueOrNull!.uid;
    return Center(
        child: Column(
      children: [
        ref.watch(postsByUidResponseProvider(uid)).when(
              data: (data) => Column(
                children: data.map((e) => PostCard(postResponse: e)).toList(),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(error.toString()),
            )
      ],
    ));
  }
}
