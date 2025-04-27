import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:nijimas/presentation/widget/home/post_search_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key, required this.initialQuery});
  final PostQuery initialQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // クエリを useState で管理
    final query = useState(initialQuery);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PostSearchDialog(
                  onQuerySelected: (newQuery) {
                    query.value = newQuery;
                  },
                );
              },
            );
          },
        ),
        TrailingIconButton(
          onPressed: () {
            final uid = ref.read(authStateProvider).valueOrNull!.uid;

            // プロフィール画面に遷移
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: UserDetailScreen(uid: uid),
              withNavBar: true,
            );
          },
          icon: Icons.account_circle,
        )
      ]),
      body: PostsLine(query: query.value, canEdit: false), // 現在のクエリを使用
      floatingActionButton: const AddPostButton(),
    );
  }
}
