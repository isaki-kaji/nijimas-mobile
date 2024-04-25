import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as image_lib;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/util/show_picker.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageHeight = Sizing.heightByMQ(context, 0.2);
    final imageWidth = Sizing.widthByMQ(context, 0.6);
    final useMainCategory = useState<String>("その他");
    final useSelectedSubCategories =
        useState<List<String>>(["かつおぶし", "たつの落とし子のおかげでした。"]);
    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List?>>([]);
    Future<void> selectImages() async {
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

    void removeSubCategory(String subCategory) {
      useSelectedSubCategories.value = useSelectedSubCategories.value
          .where((s) => s != subCategory)
          .toList();
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
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainCategoryChip(
                              categoryName: useMainCategory.value,
                              tapEvent: (s) => showPicker(context, (s) {
                                    useMainCategory.value = s;
                                  })),
                          ...useSelectedSubCategories.value.map((s) {
                            return SubCategoryChip(
                                categoryName: s,
                                tapEvent: (s) => removeSubCategory(s));
                          }),
                          if (useSelectedSubCategories.value.length < 2)
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add_circle_outline))
                        ],
                      ),
                    ),
                  )),
              if (useImageBitmap.value.isNotEmpty)
                GestureDetector(
                  onTap: () => selectImages(),
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
                  onTap: () => selectImages(),
                  child: DottedBorder(
                    color: Theme.of(context).colorScheme.secondary,
                    dashPattern: const [6, 6],
                    strokeWidth: 2.0,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12.0),
                    child: SizedBox(
                      height: imageHeight,
                      width: Sizing.widthByMQ(context, 0.8),
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
