import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:nijimas/presentation/widget/home/post_search_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(postQueryNotifierProvider);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const PostSearchDialog();
              },
            );
          },
        ),
        TrailingIconButton(
          onPressed: () {
            final uid = ref.read(authStateProvider).valueOrNull!.uid;

            // タブを切り替える
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: UserDetailScreen(uid: uid), // プロフィール画面
              withNavBar: true, // ボトムバーを表示したままにする
            );
          },
          icon: Icons.account_circle,
        )
      ]),
      body: PostsLine(query: query, canEdit: false),
      floatingActionButton: const AddPostButton(),
    );
  }
}
