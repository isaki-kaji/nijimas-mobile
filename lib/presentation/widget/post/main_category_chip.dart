import 'package:flutter/material.dart';

class MainCategoryChip extends StatelessWidget {
  final String categoryName;
  final void Function(String) tapEvent;
  const MainCategoryChip({
    super.key,
    required this.categoryName,
    required this.tapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapEvent(categoryName),
      child: Card(
        color: Colors.lightGreen,
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
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_drop_down,
                    size: 18, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
