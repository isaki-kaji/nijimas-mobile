import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key, required this.query});
  final PostQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = useState(false);
    final searchController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: isSearching.value
              ? TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "サブカテゴリで検索...",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    pushWithNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedScreen(
                          query: PostQuery(
                            type: PostQueryType.subCategory,
                            params: {PostQueryKey.subCategory: value},
                          ),
                        ),
                      ),
                    );
                    isSearching.value = false;
                  },
                )
              : const SizedBox.shrink(),
          actions: [
            if (!isSearching.value)
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  isSearching.value = true;
                },
              ),
            if (isSearching.value)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  isSearching.value = false;
                  searchController.clear();
                },
              ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () async {
                final myUid = ref.watch(authStateProvider).valueOrNull?.uid;

                final user = ref.read(authStateProvider).valueOrNull;
                if (user != null) {
                  // Firebase User のトークンを取得してログ出力
                  final idToken = await user.getIdToken();
                  log("User UID: ${user.uid}");
                  log("ID Token: $idToken");
                }
                if (myUid != null) {
                  pushWithNavBar(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(uid: myUid),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: PostsLine(query: query, canEdit: false),
        floatingActionButton: const AddPostButton(heroTag: "feed"),
      ),
    );
  }
}
