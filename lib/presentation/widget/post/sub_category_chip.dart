import 'package:flutter/material.dart';

class SubCategoryChip extends StatelessWidget {
  final String categoryName;
  final void Function(String) tapEvent;
  const SubCategoryChip({
    super.key,
    required this.categoryName,
    required this.tapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapEvent(categoryName),
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
                  Text(
                    categoryName,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(Icons.close, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
