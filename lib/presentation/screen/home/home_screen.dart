import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/observer/home_tab_navigator_observer.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/screen/data/data_screen.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';
import 'package:nijimas/presentation/screen/notification/notification_screen.dart';
import 'package:nijimas/presentation/screen/other/other_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final PersistentTabController _controller = PersistentTabController();

  List<PersistentTabConfig> _tabs(WidgetRef ref) => [
        PersistentTabConfig(
            screen: const FeedScreen(
              query: PostQuery(
                type: PostQueryType.timeline,
                params: {},
              ),
            ),
            navigatorConfig: NavigatorConfig(navigatorObservers: [
              HomeTabNavigatorObserver(
                onAllScreensPopped: () {
                  ref.invalidate(postsMapNotifierProvider);
                  ref
                      .read(postsMapNotifierProvider.notifier)
                      .showCurrentStates();
                },
              ),
            ]),
            item: ItemConfig(
                icon: const Icon(Icons.home),
                activeForegroundColor: MyColors.pink),
            onSelectedTabPressWhenNoScreensPushed: () {
              ref.invalidate(postsMapNotifierProvider);
            }),
        PersistentTabConfig(
          screen: const DataScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.bar_chart),
              activeForegroundColor: MyColors.pink),
        ),
        PersistentTabConfig(
          screen: const NotificationScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.notifications),
              activeForegroundColor: MyColors.pink),
        ),
        PersistentTabConfig(
          screen: const OtherScreen(),
          item: ItemConfig(
              icon: const Icon(Icons.settings),
              activeForegroundColor: MyColors.pink),
        ),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) {
      GoRouter.of(context).go('/login');
      return const SizedBox();
    }

    return PersistentTabView(
      tabs: _tabs(ref),
      controller: _controller,
      navBarHeight: Sizing.heightByMQ(context, 0.08),
      popActionScreens: PopActionScreensType.all,
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
      ),
      navBarOverlap: const NavBarOverlap.full(),
      popAllScreensOnTapOfSelectedTab: true,
    );
  }
}
