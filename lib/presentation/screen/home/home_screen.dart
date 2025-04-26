import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/presentation/screen/data/data_screen.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';
import 'package:nijimas/presentation/screen/notification/notification_screen.dart';
import 'package:nijimas/presentation/screen/other/other_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final PersistentTabController _controller = PersistentTabController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) {
      GoRouter.of(context).go('/login');
      return const SizedBox();
    }

    int previousIndex = _controller.index; // 前回のタブインデックスを追跡

    return PersistentTabView(
      context,
      controller: _controller,
      screens: const [
        FeedScreen(),
        DataScreen(),
        NotificationScreen(),
        OtherScreen(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          activeColorPrimary: MyColors.pink,
          inactiveColorPrimary: MyColors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.bar_chart),
          activeColorPrimary: MyColors.pink,
          inactiveColorPrimary: MyColors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications),
          activeColorPrimary: MyColors.pink,
          inactiveColorPrimary: MyColors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          activeColorPrimary: MyColors.pink,
          inactiveColorPrimary: MyColors.grey,
        ),
      ],
      navBarStyle: NavBarStyle.style1,
      onItemSelected: (index) {
        if (index == 0 && previousIndex == 0) {
          ref.read(postQueryNotifierProvider.notifier).reset();
          ref.invalidate(postsMapNotifierProvider);
        }
        previousIndex = index;
      },
    );
  }
}
