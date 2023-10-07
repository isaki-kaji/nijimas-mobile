import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/theme/text_styles.dart';
import 'package:nijimas/core/utils.dart';
import 'package:routemaster/routemaster.dart';
import 'package:toggle_switch/toggle_switch.dart';

//レンダリングしたときに現在地が本日登録済みかを読み取る
//waterに魚が泳ぐアニメーションをつけたい

class DoNijimasScreen extends HookConsumerWidget {
  const DoNijimasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).size;
    final useIsPushed = useState(false);
    bool isPublic = true;

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
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: mediaQuery.height * 0.8),
            from: const Duration(milliseconds: 800),
            to: const Duration(milliseconds: 1100),
            tag: "waterLevel")
        .animate(animationController);

    useEffect(() {
      if (useIsPushed.value) {
        animationController.forward();
      }
      return null;
    }, [useIsPushed.value]);

    useEffect(() {
      checkLocationPermission().then((locationPermission) {
        if (locationPermission == LocationPermission.denied) {
          showErrorSnackBar(context, Constants.errorMessage);
          Routemaster.of(context).pop();
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                final waterLevel = sequenceAnimation['waterLevel'].value;
                return GestureDetector(
                  onTap: () {
                    if (useIsPushed.value) {
                      useIsPushed.value = false;
                      animationController.reset();
                    }
                  },
                  child: Container(
                    color: MyColors.pinkColor,
                    height: waterLevel,
                    width: mediaQuery.width,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: mediaQuery.height * 0.1),
                      child: (waterLevel >= mediaQuery.height * 0.8)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 30),
                                  child: Text(
                                    Constants.doNijimasDescription,
                                    style: TextStyles.description(15),
                                  ),
                                ),
                                BlinkText(
                                  "push",
                                  style: TextStyles.push(),
                                  beginColor: MyColors.pinkColor,
                                  endColor: MyColors.whiteColor,
                                  duration: const Duration(seconds: 1),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: kToolbarHeight),
              child: Text("Nijimas!!", style: TextStyles.title(60)),
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: Center(
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
                                  MediaQuery.of(context).size.height *
                                      iconPosition;

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
                            padding:
                                const EdgeInsets.only(bottom: kToolbarHeight),
                            height: mediaQuery.height * 0.8,
                            width: mediaQuery.width * 0.8,
                            //ここを変える、ジェスチャーを付け替える
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (!useIsPushed.value) {
                                      useIsPushed.value = true;
                                    }
                                  },
                                  child: const SizedBox(
                                    height: 280,
                                    child: Card(
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
                                const SizedBox(height: 30),
                                ToggleSwitch(
                                  minWidth: 90.0,
                                  initialLabelIndex: 1,
                                  cornerRadius: 20.0,
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.grey,
                                  inactiveFgColor: Colors.white,
                                  totalSwitches: 2,
                                  labels: const ['Private', 'Public'],
                                  activeBgColors: const [
                                    [MyColors.pinkColor],
                                    [MyColors.pinkColor]
                                  ],
                                  onToggle: (index) {
                                    (index == 1)
                                        ? isPublic = true
                                        : isPublic = false;
                                  },
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              )),
        ],
      ),
      floatingActionButton: useIsPushed.value
          ? null
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: MyColors.lightGreen,
              ),
            ),
    );
  }
}
