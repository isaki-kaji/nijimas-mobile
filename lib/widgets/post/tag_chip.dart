import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class TagChip extends StatelessWidget {
  final String tagName;
  final void Function(String) removeTag;

  const TagChip({Key? key, required this.tagName, required this.removeTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => removeTag(tagName),
      child: Card(
        color: MyColors.whiteColor,
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
                Text(tagName),
                const Icon(Icons.close, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
