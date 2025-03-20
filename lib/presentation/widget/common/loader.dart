import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.inkDrop(
            color: Theme.of(context).colorScheme.primary, size: 50));
  }
}

class NewtonLoader extends StatelessWidget {
  const NewtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.newtonCradle(
            color: Theme.of(context).colorScheme.primary, size: 80));
  }
}
