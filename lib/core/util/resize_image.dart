import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;

Future<List<Uint8List>> resizeImages(List<XFile?> imageFiles) async {
  final List<Uint8List> resizedImages = [];

  for (final imageFile in imageFiles) {
    if (imageFile == null) {
      continue;
    }

    // 画像をバイトデータとして読み込む
    final imageBitmap = await imageFile.readAsBytes();
    final image = image_lib.decodeImage(imageBitmap);
    if (image == null) {
      continue;
    }

    const int targetWidth = 1080;
    final image_lib.Image resizedImage = image_lib.copyResize(
      image,
      width: targetWidth, // **常に横幅を1080pxに統一**
      maintainAspect: true,
      interpolation: image_lib.Interpolation.cubic, // **高品質な補間**
    );

    // **JPEGで保存 (quality: 90)**
    resizedImages.add(image_lib.encodeJpg(resizedImage, quality: 90));
  }

  return resizedImages;
}
