import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/own_user_detail_provider.dart';
import 'package:nijimas/application/state/posts_by_uid_response.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(ownUserDetailProvider).valueOrNull?.uid;
    if (uid == null) {
      return Text("");
    }
    return ref.watch(postsByUidResponseProvider(uid)).when(data: (data) {
      return PostCard(postResponse: data[0]);
    }, error: (error, _) {
      return Text(error.toString());
    }, loading: () {
      return const Loader();
    });
  }
}
