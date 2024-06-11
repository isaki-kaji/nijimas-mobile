import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/constant/animation_constant.dart';
import 'package:nijimas/core/constant/page_constant.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/home/menu_drawer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomeScreen extends HookConsumerWidget {
  final bool isShowAnimation;
  const HomeScreen({required this.isShowAnimation, super.key});

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useIsVisible = useState(isShowAnimation ? true : false);
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) {
      GoRouter.of(context).go('/login');
      return const SizedBox();
    }

    final uid = user.uid;
    final usePage = useState(0);
    final initialQuery = PostQuery(
      type: PostQueryType.uid,
      params: {PostQueryKey.uid: uid},
    );
    final usePostQuery = useState(initialQuery);

    void onPageChanged(int index) {
      usePage.value = index;
    }

    final animationController = useAnimationController(
        duration: const Duration(seconds: 1),
        initialValue: AnimationConstants.upperWaveHeight,
        upperBound: AnimationConstants.upperWaveHeight,
        lowerBound: AnimationConstants.lowerWaveHeight);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        useIsVisible.value = false;
      }
    });

    useEffect(() {
      if (isShowAnimation) {
        animationController.reverse();
      }
      return null;
    }, [isShowAnimation]);

    return Scaffold(
      appBar: useIsVisible.value
          ? null
          : AppBar(
              leading: usePage.value == 0
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final query = PostQuery(
                          type: PostQueryType.mainCategory,
                          params: {
                            PostQueryKey.mainCategory:
                                MainCategory.fashion.name,
                          },
                        );
                        usePostQuery.value = query;
                      },
                    )
                  : null,
              actions: [
                Builder(
                  builder: (context) {
                    return TrailingIconButton(
                        onPressed: () async {
                          showEndDrawer(context);
                          final user = ref.read(authStateProvider).value!;
                          final token = await user.getIdToken();
                          final uuid = user.uid;
                          if (token == null) {
                            return;
                          }
                          log(token);
                          log(uuid);
                        },
                        icon: Icons.account_circle);
                  },
                )
              ],
            ),
      endDrawer: const MenuDrawer(),
      body: PageConstant.getTabPage(usePage.value, usePostQuery.value),
      bottomSheet: useIsVisible.value
          ? AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return CustomWave(
                  waveColor: MyColors.getWaveColors(),
                  waveHeight:
                      Sizing.heightByMQ(context, animationController.value),
                );
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: useIsVisible.value
          ? null
          : FloatingActionButton(
              onPressed: () => GoRouter.of(context).push('/post/add'),
              backgroundColor: MyColors.pink,
              child: const Icon(
                Icons.add,
                color: MyColors.white,
              ),
            ),
      bottomNavigationBar: useIsVisible.value
          ? null
          : StylishBottomBar(
              currentIndex: usePage.value,
              onTap: onPageChanged,
              hasNotch: true,
              option: AnimatedBarOptions(
                iconSize: 25.0,
                iconStyle: IconStyle.animated,
              ),
              items: [
                BottomBarItem(
                    icon: const Icon(Icons.home), title: const Text("Home")),
                BottomBarItem(
                    icon: const Icon(Icons.bar_chart),
                    title: const Text("Data"))
              ],
            ),
    );
  }
}
