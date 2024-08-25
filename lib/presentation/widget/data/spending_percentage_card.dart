import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/text_style.dart';

class SpendingPercentageCard extends StatelessWidget {
  final String title;
  final Map<MainCategory, double> spendingPercentages;
  final Widget chart;
  final Widget dataView;

  const SpendingPercentageCard(
      {super.key,
      required this.title,
      required this.spendingPercentages,
      required this.chart,
      required this.dataView});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: MyTextStyles.body16,
            ),
            const SizedBox(height: 16.0),
            chart,
            const SizedBox(height: 16.0),
            dataView,
          ],
        ),
      ),
    );
  }
}
