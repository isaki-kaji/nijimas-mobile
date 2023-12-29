import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/widgets/nijimas/two_dimensional_grid_view.dart';

class NijimasMapScreen extends HookConsumerWidget {
  const NijimasMapScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: TwoDimensionalGridView(
      diagonalDragBehavior: DiagonalDragBehavior.free,
      delegate: TwoDimensionalChildBuilderDelegate(
        maxXIndex: 20,
        maxYIndex: 20,
        builder: (BuildContext context, ChildVicinity vicinity) {
          return Container(
            color: vicinity.xIndex.isEven && vicinity.yIndex.isEven
                ? Colors.amber[50]
                : (vicinity.xIndex.isOdd && vicinity.yIndex.isOdd
                    ? Colors.purple[50]
                    : Colors.white),
            height: 200,
            width: 200,
          );
        },
      ),
    ));
  }
}
