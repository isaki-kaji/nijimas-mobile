import 'dart:typed_data';

import 'package:nijimas/repository/image_repository.dart';
import 'package:uuid/uuid.dart';

class ImageUsecase {
  final ImageRepository _imageRepository;

  ImageUsecase({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<String> uploadImage(List<Uint8List?> imagesData, String path) async {
    final List<String> downloadUrls = [];
    for (var imageData in imagesData) {
      const uuid = Uuid();
      final imageId = uuid.v4();
      String fullPath = '$path/$imageId';
      final downloadUrl =
          await _imageRepository.uploadImage(imageData!, fullPath);
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls.join(',');
  }
}
