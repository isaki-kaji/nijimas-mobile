import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/user_response_provider.dart';
import 'package:nijimas/core/constant/animation_constant.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/core/util/sizing.dart';

class HomeScreen extends HookConsumerWidget {
  final bool isShowAnimation;
  const HomeScreen({required this.isShowAnimation, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useIsVisible = useState(isShowAnimation ? true : false);
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
                  IconButton(
                      onPressed: () async {}, icon: const Icon(Icons.star))
                ],
              ),
        body: Center(
          child: Text(isShowAnimation.toString()),
        ),
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
        floatingActionButton: useIsVisible.value
            ? null
            : FloatingActionButton(
                onPressed: () {
                  ref.read(authUsecaseProvider).signOut();
                  //GoRouter.of(context).go('/user/profile');
                },
                child: const Icon(Icons.add),
              ));
  }
}
