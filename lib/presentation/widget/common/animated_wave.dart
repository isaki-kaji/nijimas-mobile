import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedWave extends HookWidget {
  final double waveHeight;
  const AnimatedWave(this.waveHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    final waveController = useAnimationController(
      duration: const Duration(seconds: 3),
    );

    useEffect(() {
      waveController.repeat(reverse: true);
      return null;
    }, []);

    return AnimatedBuilder(
      animation: waveController,
      builder: (context, child) {
        final path = _getPath(context, waveController.value);
        return ClipPath(
          clipper: WaveClipper(path),
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            height: waveHeight,
          ),
        );
      },
    );
  }

  Path _getPath(BuildContext context, double waveControllerValue) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final path = Path();
    for (var i = 0; i <= width / 3; i++) {
      final step = (i / width) - waveControllerValue;
      path.lineTo(
        i.toDouble() * 3,
        math.sin(step * 2 * math.pi) * 45 + height * 0.5,
      );
    }

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }
}

class WaveClipper extends CustomClipper<Path> {
  final Path path;

  WaveClipper(this.path);

  @override
  Path getClip(Size size) => path;

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}
