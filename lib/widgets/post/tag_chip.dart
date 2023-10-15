import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class TagChip extends StatelessWidget {
  final String tagName;
  final void Function(String) removeTag;

  const TagChip({Key? key, required this.tagName, required this.removeTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Text(tagName),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                padding: EdgeInsets.zero, // IconButtonのパディングを0に
                constraints: const BoxConstraints(), // サイズ制約をリセット
                onPressed: () => removeTag(tagName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
