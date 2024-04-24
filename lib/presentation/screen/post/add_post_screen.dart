import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as image_lib;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/util/sizing.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List?>>([]);
    Future<void> selectImage() async {
      final List<XFile?> imageFiles = await picker.pickMultiImage(limit: 4);
      final List<Uint8List> resizeImages = [];
      if (imageFiles.isEmpty) {
        return;
      }
      for (final imageFile in imageFiles) {
        if (imageFile == null) {
          continue;
        }
        final imageBitmap = await imageFile.readAsBytes();
        final image = image_lib.decodeImage(imageBitmap);
        if (image == null) {
          continue;
        }
        final image_lib.Image resizedImage;
        if (image.width > image.height) {
          resizedImage =
              image_lib.copyResize(image, width: 500, maintainAspect: true);
        } else {
          resizedImage =
              image_lib.copyResize(image, height: 500, maintainAspect: true);
        }
        resizeImages.add(image_lib.encodePng(resizedImage));
      }
      useImageBitmap.value = resizeImages;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30.0,
          icon: const Icon(Icons.close),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (useImageBitmap.value.isNotEmpty)
              CarouselSlider(
                  items: useImageBitmap.value.map((i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: SizedBox(
                        height: Sizing.heightByMQ(context, 0.3),
                        width: Sizing.widthByMQ(context, 0.8),
                        child: Image.memory(i!, fit: BoxFit.cover),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: Sizing.heightByMQ(context, 0.3),
                    viewportFraction: 0.8,
                  )),
            ElevatedButton(
              onPressed: () => selectImage(),
              child: const Text("画像を選択"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColor.pink,
        child: const Icon(
          Icons.done,
          color: MyColor.white,
        ),
      ),
    );
  }
}
