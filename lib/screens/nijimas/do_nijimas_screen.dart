import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class DoNijimasScreen extends HookConsumerWidget {
  const DoNijimasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useIsPushed = useState(false);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 5),
    );

    final sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(seconds: 0),
          to: const Duration(seconds: 2),
          tag: "iconPosition",
        )
        .animate(animationController);

    useEffect(() {
      if (useIsPushed.value) {
        animationController.forward();
      }
      return null;
    }, [useIsPushed.value]);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (!useIsPushed.value) {
              useIsPushed.value = true;
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 0),
            child: useIsPushed.value
                ? AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      // アイコンの位置を取得
                      final iconPosition =
                          sequenceAnimation['iconPosition'].value;

                      // アイコンの位置を計算
                      final translateY =
                          MediaQuery.of(context).size.height * iconPosition;

                      return Transform.translate(
                        offset: Offset(0, translateY),
                        child: child,
                      );
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.droplet,
                      color: MyColors.pinkColor,
                      size: 180,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(bottom: kToolbarHeight),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Card(
                      shape: CircleBorder(),
                      elevation: 6.0,
                      color: Colors.white,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.droplet,
                          color: MyColors.pinkColor,
                          size: 180,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
