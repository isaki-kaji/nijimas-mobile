import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/nijimas_controller.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/nijimas_notifier_provider.dart';
import 'package:nijimas/core/router/navigators.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/theme/text_styles.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/models/nijimas_model.dart';
import 'package:nijimas/test/test_data.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';
import 'package:nijimas/widgets/nijimas/center_button.dart';

//レンダリングしたときに現在地が本日登録済みかを読み取る
//→getSectionする。
//waterに魚が泳ぐアニメーションをつけたい

//新しい区画に入ったら何か合図を出す

class DoNijimasScreen extends HookConsumerWidget {
  const DoNijimasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).size;
    final useIsInAnimation = useState(false);
    final useIsAddPostButton = useState(false);
    final useSelectedNijimasNum = useState(0);
    late Nijimas selectedNijimas;
    final isLoading = ref.watch(nijimasControllerProvider);

    final currentNijimas =
        ref.watch(getCurrentNijimasProvider(TestData.section));
    final todayNijimas = ref.watch(getTodayNijimasProvider);

    void doNijimas() async {
      final isPushed = await ref
          .read(nijimasControllerProvider.notifier)
          .doNijimas(context: context);
      if (isPushed) {
        useIsInAnimation.value = true;
      }
    }

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
      if (useIsInAnimation.value) {
        animationController.forward();
      }
      return null;
    }, [useIsInAnimation.value]);

    useEffect(() {
      currentNijimas.when(
        data: (data) {
          if (data.isNotEmpty) {
            useIsAddPostButton.value = true;
          }
        },
        loading: () => const Loader(),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
      );
      return null;
    }, []);

    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? const Loader()
            //アニメーション中かどうかで最上位制御
            : !useIsInAnimation.value
                ? todayNijimas.when(
                    data: (data) {
                      return Stack(children: [
                        if (data.isNotEmpty && useIsAddPostButton.value)
                          //Positionedを広げて、かつCenterでラップすることでRowを広げる
                          Positioned(
                            top: 15,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: data.map((nijimas) {
                                    if (data.indexOf(nijimas) == 0 &&
                                        useSelectedNijimasNum.value == 0) {
                                      selectedNijimas = nijimas;
                                    }
                                    return SizedBox(
                                      width: useSelectedNijimasNum.value ==
                                              data.indexOf(nijimas)
                                          ? 160
                                          : 140,
                                      height: useSelectedNijimasNum.value ==
                                              data.indexOf(nijimas)
                                          ? 100
                                          : 80,
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(nijimasProvider.notifier)
                                              .update(nijimas);
                                          useSelectedNijimasNum.value =
                                              data.indexOf(nijimas);
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            color: MyColors.whiteColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(nijimas.section),
                                            )),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (data.isNotEmpty && useIsAddPostButton.value)
                                ? CenterButton(
                                    icon: FontAwesomeIcons.plus,
                                    onTap: () {
                                      if (useSelectedNijimasNum.value == 0) {
                                        ref
                                            .read(nijimasProvider.notifier)
                                            .update(selectedNijimas);
                                      }
                                      Navigators.toAddPost(context);
                                    })
                                : CenterButton(
                                    icon: FontAwesomeIcons.droplet,
                                    onTap: () {
                                      currentNijimas.when(
                                        data: (data) {
                                          if (data.isNotEmpty) {
                                            showErrorSnackBar(context,
                                                "本日「${TestData.section}」区画のNijimasは登録済みです。");
                                          } else {
                                            doNijimas();
                                          }
                                        },
                                        loading: () => const Loader(),
                                        error: (error, stackTrace) =>
                                            ErrorText(error: error.toString()),
                                      );
                                    }),
                            const SizedBox(height: 30),
                            if (data.isNotEmpty)
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.rotate,
                                  color: MyColors.pinkColor,
                                  size: 30,
                                ),
                                onPressed: () {
                                  useIsAddPostButton.value =
                                      !useIsAddPostButton.value;
                                },
                              )
                            else
                              const SizedBox(height: 50),
                          ],
                        ),
                      ]);
                    },
                    loading: () => const Loader(),
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()))
                : Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            final waterLevel =
                                sequenceAnimation['waterLevel'].value;
                            return GestureDetector(
                              onTap: () {
                                if (useIsInAnimation.value) {
                                  useIsInAnimation.value = false;
                                  useIsAddPostButton.value = true;
                                  animationController.reset();
                                }
                              },
                              child: Container(
                                color: MyColors.pinkColor,
                                height: waterLevel,
                                width: mediaQuery.width,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: mediaQuery.height * 0.1),
                                  child: (waterLevel >= mediaQuery.height * 0.8)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40.0,
                                                      vertical: 30),
                                              child: Text(
                                                Constants.doNijimasDescription,
                                                style:
                                                    TextStyles.description(15),
                                              ),
                                            ),
                                            BlinkText(
                                              "push",
                                              style: TextStyles.push(),
                                              beginColor: MyColors.pinkColor,
                                              endColor: MyColors.whiteColor,
                                              duration:
                                                  const Duration(seconds: 1),
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
                          padding:
                              const EdgeInsets.only(bottom: kToolbarHeight),
                          child: Text("Nijimas!!", style: TextStyles.title(60)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (!useIsInAnimation.value) {
                                useIsInAnimation.value = true;
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(seconds: 0),
                              child: AnimatedBuilder(
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
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
        floatingActionButton: useIsInAnimation.value
            ? null
            : FloatingActionButton(
                onPressed: () {
                  currentNijimas.when(
                    data: (data) {
                      if (data.isNotEmpty) {
                        Navigators.toTakePhoto(context);
                      } else {
                        showErrorSnackBar(
                            context, Constants.cameraButtonDescription);
                      }
                    },
                    loading: () => const Loader(),
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                  );
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: MyColors.lightGreen,
                ),
              ));
  }
}
