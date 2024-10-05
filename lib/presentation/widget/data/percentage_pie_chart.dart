import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/model/calculated_summary.dart';
import 'package:nijimas/core/theme/color.dart';

class PercentagePieChart extends StatelessWidget {
  final List<CalculatedSummary> summary;
  const PercentagePieChart({super.key, required this.summary});

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
              sections: summary
                  .map((entry) => PieChartSectionData(
                        showTitle: false,
                        color: MyColors.getMainCategoryColor(
                            MainCategory.fromName(entry.categoryName)),
                        value: entry.percentage,
                        title: '${entry.percentage}%',
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
