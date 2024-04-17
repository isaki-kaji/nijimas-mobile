import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("Feed Screen"));
  }
}
