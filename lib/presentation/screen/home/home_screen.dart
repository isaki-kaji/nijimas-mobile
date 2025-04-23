import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/core/constant/animation_constants.dart';
import 'package:nijimas/core/constant/page_constant.dart';
import 'package:nijimas/core/model/year_month.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/home/menu_drawer.dart';
import 'package:nijimas/presentation/widget/home/post_search_dialog.dart';
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

    final useYearMonth = useState(YearMonth.now());
    final usePage = useState(0);

    void onPageChanged(int index) {
      if (usePage.value == 0 && index == 0) {
        ref.read(postQueryNotifierProvider.notifier).reset();
        ref.invalidate(postsMapNotifierProvider);
      }

      if (usePage.value == 1) {
        ref.invalidate(monthlySummaryPresentationProvider);
      }

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
              centerTitle: false,
              leading: usePage.value == 0
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PostSearchDialog();
                          },
                        );
                      },
                    )
                  : null,
              title: usePage.value == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                useYearMonth.value =
                                    useYearMonth.value.subtractMonth();
                              },
                              icon: const Icon(Icons.arrow_left),
                              iconSize: 40,
                              color: useYearMonth.value.canSubtract()
                                  ? MyColors.black
                                  : MyColors.lightGrey,
                            ),
                          ),
                        ),
                        Text(
                          "${useYearMonth.value.year} / ${useYearMonth.value.month}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  useYearMonth.value =
                                      useYearMonth.value.addMonth();
                                },
                                icon: const Icon(Icons.arrow_right),
                                iconSize: 40,
                                color: useYearMonth.value.isCurrent()
                                    ? MyColors.lightGrey
                                    : MyColors.black),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              actions: [
                usePage.value == 0
                    ? Builder(
                        builder: (context) {
                          return TrailingIconButton(
                              onPressed: () async {
                                final uid = ref
                                    .read(authStateProvider)
                                    .valueOrNull!
                                    .uid;

                                final user = ref.read(authStateProvider).value!;
                                final token = await user.getIdToken();
                                final uuid = user.uid;
                                if (token == null) {
                                  return;
                                }
                                log(token);
                                log(uuid);

                                GoRouter.of(context).push("/profile/$uid");
                              },
                              icon: Icons.account_circle);
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            ),
      endDrawer: const MenuDrawer(
        isGuestUser: false,
      ),
      body: PageConstants.getTabPage(usePage.value, useYearMonth.value),
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
                    title: const Text("Data")),
                BottomBarItem(
                    icon: const Icon(Icons.notifications),
                    title: const Text("Notification")),
                BottomBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text("Other")),
              ],
            ),
    );
  }
}
