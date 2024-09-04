import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';

class GridDataView extends StatelessWidget {
  const GridDataView({
    super.key,
    required this.spendingPercentages,
  });

  final Map<MainCategory, double> spendingPercentages;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // 内部のGridViewの高さを自動調整
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 30.0,
      ),
      itemCount: spendingPercentages.length,
      itemBuilder: (context, index) {
        int newIndex;
        if (index % 2 == 0) {
          newIndex = index ~/ 2;
        } else {
          newIndex = (spendingPercentages.length ~/ 2) + (index ~/ 2);
        }
        final entry = spendingPercentages.entries.elementAt(newIndex);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    color: MyColors.getMainCategoryColor(entry.key), // 背景色を設定
                    shape: BoxShape.circle, // 形状を円に設定
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(entry.key.getDisplayName(context)),
              ],
            ),
            Text('${(entry.value).toStringAsFixed(1)}%'),
          ],
        );
      },
    );
  }
}
