import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/util/sizing.dart';

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
      child: DottedBorder(
        color: Theme.of(context).colorScheme.secondary,
        dashPattern: const [6, 6],
        strokeWidth: 2.0,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12.0),
        child: SizedBox(
          height: Sizing.imageHeight(context),
          width: Sizing.widthByMQ(context, 0.8),
          child: Icon(
            Icons.camera_alt,
            size: 50.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
