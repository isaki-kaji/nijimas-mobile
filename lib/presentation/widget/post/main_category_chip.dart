import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';

class MainCategoryChip extends StatelessWidget {
  final MainCategory category;
  final void Function(MainCategory)? tapEvent;
  const MainCategoryChip({
    super.key,
    required this.category,
    this.tapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return tapEvent != null
        ? GestureDetector(
            onTap: () => tapEvent!(category),
            child: _buildWidget(context),
          )
        : _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: MyColors.lightGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  category.getDisplayName(context),
                  style: const TextStyle(
                      color: MyColors.white, fontWeight: FontWeight.bold),
                ),
                tapEvent != null
                    ? const Icon(Icons.arrow_drop_down,
                        size: 18, color: MyColors.white)
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
