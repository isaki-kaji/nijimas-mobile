import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';

class SpendingDistributionCard extends StatelessWidget {
  final String title;
  final Map<MainCategory, double> spendingDistribution;

  const SpendingDistributionCard(
      {super.key, required this.title, required this.spendingDistribution});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: MyTextStyles.subtitle,
            ),
            const SizedBox(height: 16.0),
            DistributionBarGraph(spendingDistribution: spendingDistribution),
            const SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true, // 内部のGridViewの高さを自動調整
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 60.0,
              ),
              itemCount: spendingDistribution.length,
              itemBuilder: (context, index) {
                int newIndex;
                if (index % 2 == 0) {
                  newIndex = index ~/ 2;
                } else {
                  newIndex = (spendingDistribution.length ~/ 2) + (index ~/ 2);
                }
                final entry = spendingDistribution.entries.elementAt(newIndex);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: MyColors.getMainCategoryColor(
                                entry.key), // 背景色を設定
                            shape: BoxShape.circle, // 形状を円に設定
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Text(entry.key.getDisplayName(context)),
                      ],
                    ),
                    Text('${(entry.value * 100).toStringAsFixed(1)}%'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DistributionBarGraph extends StatelessWidget {
  final Map<MainCategory, double> spendingDistribution;
  const DistributionBarGraph({super.key, required this.spendingDistribution});

  @override
  Widget build(BuildContext context) {
    //LayoutBuilderを使って、親Widgetのサイズを取得
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      return Row(
        children: spendingDistribution.entries.map((entry) {
          return Container(
            width: width * entry.value,
            height: 10,
            color: MyColors.getMainCategoryColor(entry.key),
          );
        }).toList(),
      );
    });
  }
}
