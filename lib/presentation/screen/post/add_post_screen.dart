import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
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
    final imageHeight = Sizing.heightByMQ(context, 0.2);
    final imageWidth = Sizing.widthByMQ(context, 0.6);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (useImageBitmap.value.isNotEmpty)
                GestureDetector(
                  onTap: () => selectImage(),
                  child: CarouselSlider(
                      items: useImageBitmap.value.map((i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: SizedBox(
                            height: imageHeight,
                            width: imageWidth,
                            child: Image.memory(i!, fit: BoxFit.cover),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: imageHeight,
                        viewportFraction: 0.6,
                      )),
                )
              else
                GestureDetector(
                  onTap: () => selectImage(),
                  child: DottedBorder(
                    color: Theme.of(context).colorScheme.secondary,
                    dashPattern: const [6, 6],
                    strokeWidth: 2.0,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12.0),
                    child: SizedBox(
                      height: imageHeight,
                      width: imageWidth,
                      child: Icon(
                        Icons.camera_alt,
                        size: 50.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
