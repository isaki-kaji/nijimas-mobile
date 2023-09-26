import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.inkDrop(
            color: MyColors.loaderColor, size: 50));
  }
}
