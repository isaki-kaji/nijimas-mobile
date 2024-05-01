import 'dart:typed_data';

import 'package:nijimas/application/usecase/abstract_image_usecase.dart';
import 'package:nijimas/repository/abstract_image_repository.dart';
import 'package:uuid/uuid.dart';

class ImageUsecase extends AbstractImageUsecase {
  final AbstractImageRepository _imageRepository;

  ImageUsecase({required AbstractImageRepository imageRepository})
      : _imageRepository = imageRepository;

  @override
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
