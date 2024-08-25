import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';

class PercentagePieChart extends StatelessWidget {
  final Map<MainCategory, double> spendingPercentages;
  const PercentagePieChart({super.key, required this.spendingPercentages});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilderを使って、親Widgetのサイズを取得
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width * 0.4,
          height: width * 0.4,
          child: PieChart(
            swapAnimationDuration: const Duration(milliseconds: 800),
            PieChartData(
              titleSunbeamLayout: false,
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              startDegreeOffset: 270,
              sections: spendingPercentages.entries
                  .map((entry) => PieChartSectionData(
                        showTitle: false,
                        color: MyColors.getMainCategoryColor(entry.key),
                        value: entry.value,
                        title: '${entry.value}%',
                        radius: 50,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}
