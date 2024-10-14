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
import 'package:nijimas/core/model/year_month.dart';
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

    final useMainCategory = useState<MainCategory>(MainCategory.food);
    final useYearMonth = useState(YearMonth.now());
    final usePage = useState(0);
    final initialQuery = PostQuery(
      type: PostQueryType.own,
      params: {},
    );
    final usePostQuery = useState(initialQuery);

    void onPageChanged(int index) {
      //FeedScreenでHomeを押した場合、usePostQueryを初期化する
      if (usePage.value == 0 && index == 0) {
        usePostQuery.value = initialQuery;
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
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return PostSearchModal(
                                  usePostQuery: usePostQuery);
                            });
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
                    : const SizedBox.shrink(),
              ],
            ),
      endDrawer: const MenuDrawer(),
      body: PageConstant.getTabPage(
          usePage.value, usePostQuery.value, useYearMonth.value),
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

class PostSearchModal extends HookWidget {
  PostSearchModal({
    super.key,
    required this.usePostQuery,
  });

  final ValueNotifier<PostQuery> usePostQuery;

  @override
  Widget build(BuildContext context) {
    final searchedMainCategory = useState<MainCategory?>(null);

    return Container(
      height: Sizing.heightByMQ(context, 0.8),
      margin: const EdgeInsets.only(top: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0.85, 0.85),
            child: CustomRoundButton(
              usePostQuery: usePostQuery,
              searchedMainCategory: searchedMainCategory.value,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectMainCategoryDropdown(
                  searchedMainCategory: searchedMainCategory.value,
                  onCategorySelected: (MainCategory? category) {
                    searchedMainCategory.value = category;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectMainCategoryDropdown extends HookWidget {
  SelectMainCategoryDropdown({
    super.key,
    required this.searchedMainCategory,
    required this.onCategorySelected,
  });

  final MainCategory? searchedMainCategory;
  final Function(MainCategory?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      width: Sizing.widthByMQ(context, 0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<MainCategory>(
            isExpanded: true,
            value: searchedMainCategory,
            hint: const Text("費目で検索"),
            onChanged: (MainCategory? value) {
              onCategorySelected(value);
            },
            items: getMainCategories()
                .map<DropdownMenuItem<MainCategory>>((MainCategory value) {
              return DropdownMenuItem<MainCategory>(
                value: value,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        value.getDisplayName(context),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomRoundButton extends HookWidget {
  CustomRoundButton({
    super.key,
    required this.usePostQuery,
    required this.searchedMainCategory,
  });

  final ValueNotifier<PostQuery> usePostQuery;
  final MainCategory? searchedMainCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchedMainCategory == null) {
          print("Main category is not selected");
          return;
        }
        usePostQuery.value = PostQuery(
          type: PostQueryType.mainCategory,
          params: {
            PostQueryKey.mainCategory: searchedMainCategory.toString(),
          },
        );
        Navigator.of(context).pop();
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: MyColors.pink,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.search, color: MyColors.white),
      ),
    );
  }
}
