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
    final mediaQuery = MediaQuery.of(context).size;

    final useIsPushed = useState(false);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 5),
    );

    final sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: const Duration(seconds: 0),
          to: const Duration(seconds: 4),
          tag: "iconPosition",
        )
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: mediaQuery.height * 0.8),
            from: const Duration(milliseconds: 1600),
            to: const Duration(milliseconds: 1900),
            tag: "waterLevel")
        .animate(animationController);

    useEffect(() {
      if (useIsPushed.value) {
        animationController.forward();
      }
      return null;
    }, [useIsPushed.value]);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Container(
                  color: MyColors.pinkColor,
                  height: sequenceAnimation['waterLevel'].value,
                  width: mediaQuery.width,
                );
              },
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: kToolbarHeight),
              child: Text(
                "Nijimas!!",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor),
              ),
            ),
          ),
          Center(
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
                        height: mediaQuery.height * 0.8,
                        width: mediaQuery.width * 0.8,
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
        ],
      ),
      floatingActionButton: useIsPushed.value
          ? null
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: MyColors.loaderColor,
              ),
            ),
    );
  }
}
