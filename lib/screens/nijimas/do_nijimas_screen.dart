import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class DoNijimasScreen extends HookConsumerWidget {
  const DoNijimasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    final colorAnimation = useAnimation<Color?>(
      ColorTween(
        begin: Colors.white,
        end: MyColors.pinkColor,
      ).animate(animationController),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: FloatingActionButton(
          onPressed: () {
            // ボタンが押されたときにアニメーションを開始
            animationController.forward();
          },
          backgroundColor: colorAnimation,
          child: const FaIcon(
            FontAwesomeIcons.droplet,
            color: MyColors.pinkColor,
            size: 180,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
