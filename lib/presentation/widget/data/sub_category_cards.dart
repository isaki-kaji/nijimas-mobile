import 'package:flutter/material.dart';
import 'package:nijimas/core/model/calculated_summary.dart';
import 'package:nijimas/core/theme/color.dart';

class SubCategoryCards extends StatelessWidget {
  const SubCategoryCards({super.key, required this.summary});
  final List<CalculatedSummary> summary;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300,
        minWidth: double.infinity,
      ),
      child: SingleChildScrollView(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 2,
          runSpacing: 5,
          children: summary.map((item) {
            return GestureDetector(
              onTap: () => _showDetailDialog(context, item),
              child: _buildCard(item.categoryName, item.percentage),
            );
          }).toList(),
        ),
      ),
    );
  }

  // カード表示
  Widget _buildCard(String categoryName, double percent) {
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Card(
          color: MyColors.getSubCategoryPercentColor(percent),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryName,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ダイアログを表示
  void _showDetailDialog(BuildContext context, CalculatedSummary item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.categoryName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("出費額 : ${item.amount.toInt()} 円"),
              const SizedBox(height: 20),
              Text("出費割合 : ${item.percentage.toStringAsFixed(1)} %"),
              const SizedBox(height: 20),
              Text("出費回数 : ${item.count} 回"),
            ],
          ),
        );
      },
    );
  }
}
