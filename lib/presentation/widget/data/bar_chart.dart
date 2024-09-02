import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/color.dart';

class SummaryBarChart extends StatelessWidget {
  final Map<String, double> data;
  const SummaryBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
            width: width,
            height: width * 0.6,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.start,
                maxY: data.values.isEmpty
                    ? 0
                    : data.values.reduce((a, b) => a > b ? a : b),
                minY: 0,
                groupsSpace: width * 0.1,
                titlesData: const FlTitlesData(
                  show: false, // タイトルを非表示にする
                ),
                gridData: const FlGridData(
                  show: false, // グリッドラインを非表示にする
                ),
                borderData: FlBorderData(
                  show: false, // 枠線を非表示にする
                ),
                barGroups: data.entries
                    .map((entry) => BarChartGroupData(
                          x: data.keys.toList().indexOf(entry.key),
                          barRods: [
                            BarChartRodData(
                              toY: entry.value,
                              gradient: const LinearGradient(
                                // グラデーションの場合
                                colors: [MyColors.teal, MyColors.tealAccent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => MyColors.teal,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final key = data.keys.elementAt(group.x);
                      return BarTooltipItem(
                        key,
                        const TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )),
      );
    });
  }
}
