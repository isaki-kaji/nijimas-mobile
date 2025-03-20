import 'package:flutter/material.dart';
import 'package:nijimas/presentation/widget/post/custom_dotted_border.dart';

class ImageSelectDetector extends StatelessWidget {
  const ImageSelectDetector({
    super.key,
    required this.isKeyboardShown,
    required this.selectImages,
  });

  final bool isKeyboardShown;
  final Future<void> Function() selectImages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isKeyboardShown) {
          FocusScope.of(context).unfocus();
          return;
        }
        await selectImages();
      },
      child: CustomDottedBorder(
          item: Icon(
        Icons.camera_alt,
        size: 50.0,
        color: Theme.of(context).colorScheme.secondary,
      )),
    );
  }
}
