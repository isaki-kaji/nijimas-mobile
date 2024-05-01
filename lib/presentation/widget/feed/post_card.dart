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
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/nijimas-2832c.appspot.com/o/posts%2FOKQchGYVq8Z6stnG6XS9YhBqWtZ2%2F28e0bf58-7ab0-4e37-9795-ce294054da64%2F72fb06f8-9f9f-4c56-beb8-3dff732e36e3?alt=media&token=9d2737d5-5523-48f9-adc1-c204a54d204e",
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
