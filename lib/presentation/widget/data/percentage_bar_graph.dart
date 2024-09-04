import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';

class PercentageBarChart extends StatelessWidget {
  final Map<MainCategory, double> spendingPercentages;
  const PercentageBarChart({super.key, required this.spendingPercentages});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilderを使って、親Widgetのサイズを取得
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      return Row(
        children: spendingPercentages.entries.map((entry) {
          final normalizedWidth = width * (entry.value / 100);
          return Container(
            width: normalizedWidth,
            height: 10,
            color: MyColors.getMainCategoryColor(entry.key),
          );
        }).toList(),
      );
    });
  }
}
