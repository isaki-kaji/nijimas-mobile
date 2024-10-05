import 'package:flutter/material.dart';
import 'package:nijimas/core/model/calculated_summary.dart';

class SubCategoryCards extends StatelessWidget {
  const SubCategoryCards({super.key, required this.summary});
  final List<CalculatedSummary> summary;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: summary.map((e) {
              return _buildCard(e.categoryName, e.amount);
            }).toList())));
  }

  Widget _buildCard(String categoryName, double amount) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(categoryName),
            const SizedBox(height: 10),
            Text("${amount.toInt()} 円")
          ],
        ),
      ),
    );
  }
}
