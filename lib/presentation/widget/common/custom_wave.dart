import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CustomWave extends StatelessWidget {
  final List<List<Color>> waveColor;
  final double waveHeight;

  const CustomWave({
    required this.waveColor,
    required this.waveHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      backgroundColor: Theme.of(context).colorScheme.background,
      config: CustomConfig(
        gradients: waveColor,
        durations: [10000, 8000],
        heightPercentages: [0.005, 0.01],
      ),
      waveAmplitude: 0,
      size: Size(
        double.infinity,
        waveHeight,
      ),
    );
  }
}
