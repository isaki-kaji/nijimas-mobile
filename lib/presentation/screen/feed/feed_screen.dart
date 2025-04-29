import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key, required this.query});
  final PostQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = useState(false);
    final searchController = useTextEditingController();

    return Scaffold(
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
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: FeedScreen(
                      query: PostQuery(
                        type: PostQueryType.subCategory,
                        params: {PostQueryKey.subCategory: value},
                      ),
                    ),
                    withNavBar: true,
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
          TrailingIconButton(
            onPressed: () {
              final uid = ref.read(authStateProvider).valueOrNull!.uid;

              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: UserDetailScreen(uid: uid),
                withNavBar: true,
              );
            },
            icon: Icons.account_circle,
          ),
        ],
      ),
      body: PostsLine(query: query, canEdit: false),
      floatingActionButton: const AddPostButton(heroTag: "feed"),
    );
  }
}
