import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as image_lib;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/core/theme/my_color.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _picker = ImagePicker();
    final useImageBitmap = useState<Uint8List?>(null);
    Future<void> _selectImage() async {
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.gallery);
      final imageBitmap = await imageFile?.readAsBytes();
      if (imageBitmap == null) {
        return;
      }
      final image = image_lib.decodeImage(imageBitmap);
      if (image == null) {
        return;
      }
      final image_lib.Image resizedImage;
      if (image.width > image.height) {
        resizedImage = image_lib.copyResize(image, width: 500);
      } else {
        resizedImage = image_lib.copyResize(image, height: 500);
      }
      useImageBitmap.value = image_lib.encodeBmp(resizedImage);
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
            if (useImageBitmap.value != null)
              Image.memory(useImageBitmap.value!),
            ElevatedButton(
              onPressed: () => _selectImage(),
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
