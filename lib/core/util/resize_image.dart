import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;

Future<List<Uint8List>> resizeImages(List<XFile?> imageFiles) async {
  final List<Uint8List> resizeImages = [];

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
  return resizeImages;
}
