import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';

class PostCard extends HookConsumerWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).valueOrNull!.uid;
    return Column(
      children: [
        // Image.network(
        //   "",
        //   fit: BoxFit.cover,
        // )
      ],
    );
  }
}
