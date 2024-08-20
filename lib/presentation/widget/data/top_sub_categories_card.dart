import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';

class TopSubCategoriesCard extends StatelessWidget {
  const TopSubCategoriesCard({super.key, required this.subCategories});
  final List<String> subCategories;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "支出の多いサブカテゴリ",
                  style: MyTextStyles.body16,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: subCategories.map((s) {
                      return SubCategoryChip(categoryName: s);
                    }).toList()))),
          ],
        ),
      ),
    );
  }
}
