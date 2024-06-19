import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/text_style.dart';

class SpendingRatesCard extends StatelessWidget {
  final String title;
  final Map<String, double> spendingRates;

  const SpendingRatesCard(
      {super.key, required this.title, required this.spendingRates});

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
            GridView.builder(
              shrinkWrap: true, // 内部のGridViewの高さを自動調整
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 60.0,
              ),
              itemCount: spendingRates.length,
              itemBuilder: (context, index) {
                final entry = spendingRates.entries.elementAt(index);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text('${entry.value.toStringAsFixed(2)}%'),
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
