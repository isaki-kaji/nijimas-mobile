import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/color.dart';

class SubCategoryChip extends StatelessWidget {
  final String categoryName;
  final String? categoryId;
  final void Function(String)? tapEvent;
  final bool showIcon;
  final FontWeight fontWeight;
  const SubCategoryChip({
    super.key,
    required this.categoryName,
    this.categoryId,
    this.tapEvent,
    this.showIcon = false,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return tapEvent != null
        ? GestureDetector(
            onTap: () => tapEvent!(categoryName),
            child: _buildCard(),
          )
        : _buildCard();
  }

  Widget _buildCard() {
    return GestureDetector(
      child: SizedBox(
        height: 50,
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Text(categoryName,
                      style: TextStyle(
                          color: MyColors.black, fontWeight: fontWeight)),
                  showIcon == true
                      ? const Icon(Icons.close, size: 18)
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
