import 'package:flutter/material.dart';

class SubCategoryCards extends StatelessWidget {
  const SubCategoryCards({super.key, required this.subCategories});
  final Map<String, double> subCategories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: subCategories.entries.map((e) {
                return _buildCard(e.key, e.value);
              }).toList()))),
    );
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
