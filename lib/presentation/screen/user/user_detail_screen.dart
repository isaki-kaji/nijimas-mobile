import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:nijimas/presentation/widget/user/profile_header.dart';

class UserDetailScreen extends HookConsumerWidget {
  const UserDetailScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;
    final isOwnScreen = myUid == uid;

    final query = PostQuery(
      type: PostQueryType.uid,
      params: {PostQueryKey.uid: uid},
    );

    return DefaultTabController(
      length: isOwnScreen ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            if (isOwnScreen)
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(l10n.editProfile),
                    onTap: () =>
                        GoRouter.of(context).push("/profile/$myUid/edit"),
                  ),
                ],
              ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: ProfileHeader(uid: uid)),
            if (isOwnScreen)
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    tabs: [
                      CustomTab(label: l10n.post, icon: Icons.article_outlined),
                      CustomTab(
                          label: l10n.favorite, icon: Icons.favorite_border),
                    ],
                  ),
                ),
              ),
          ],
          body: isOwnScreen
              ? TabBarView(
                  children: [
                    PostsLine(
                      query: PostQuery(type: PostQueryType.own, params: {}),
                      canTap: false,
                      canEdit: isOwnScreen,
                      shouldNavigate: true,
                    ),
                    PostsLine(
                      query:
                          PostQuery(type: PostQueryType.favorite, params: {}),
                      canTap: true,
                      canEdit: false,
                      shouldNavigate: true,
                    ),
                  ],
                )
              : PostsLine(
                  query: query,
                  canTap: false,
                  canEdit: false,
                ),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
