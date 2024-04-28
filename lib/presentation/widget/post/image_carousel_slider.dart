import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/util/sizing.dart';

class ImageCarouselSlider extends StatelessWidget {
  const ImageCarouselSlider({
    super.key,
    required this.isKeyboardShown,
    required this.useImageBitmap,
    required this.selectImages,
  });

  final bool isKeyboardShown;
  final ValueNotifier<List<Uint8List?>> useImageBitmap;
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
      child: CarouselSlider(
          items: useImageBitmap.value.map((i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: SizedBox(
                height: Sizing.imageHeight(context),
                width: Sizing.imageWidth(context),
                child: Image.memory(i!, fit: BoxFit.cover),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: Sizing.imageHeight(context),
            viewportFraction: 0.6,
          )),
    );
  }
}
