import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constant/animation_constant.dart';
import 'package:nijimas/core/constant/page_constant.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/home/menu_drawer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomeScreen extends HookConsumerWidget {
  final bool isShowAnimation;
  const HomeScreen({required this.isShowAnimation, super.key});

  void showEndDrawer(BuildContext context) async {
    Scaffold.of(context).openEndDrawer();
    // final user = ref.read(authStateProvider).value!;
    // final token = await user.getIdToken();
    // final uuid = user.uid;
    // if (token == null) {
    //   return;
    // }
    // log(token);
    // log(uuid);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useIsVisible = useState(isShowAnimation ? true : false);
    final usePage = useState(0);
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
              actions: [
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () async => showEndDrawer(context),
                          iconSize: 30.0,
                          icon: const Icon(Icons.account_circle)),
                    );
                  },
                )
              ],
            ),
      endDrawer: const MenuDrawer(),
      body: PageConstant.tabPages[usePage.value],
      bottomSheet: useIsVisible.value
          ? AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return CustomWave(
                  waveColor: MyColor.getWaveColors(),
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
              backgroundColor: MyColor.pink,
              child: const Icon(
                Icons.add,
                color: MyColor.white,
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
