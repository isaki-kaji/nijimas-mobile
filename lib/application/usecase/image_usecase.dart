import 'dart:typed_data';

import 'package:nijimas/repository/image_repository.dart';
import 'package:uuid/uuid.dart';

class ImageUsecase {
  final ImageRepository _imageRepository;

  ImageUsecase({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<String> uploadPostImages(
      List<Uint8List?> imagesData, String uid, String postId) async {
    final List<String> downloadUrls = [];
    try {
      for (var imageData in imagesData) {
        const uuid = Uuid();
        final imageId = uuid.v4();
        String path = 'posts/$uid/$postId/$imageId';
        final downloadUrl =
            await _imageRepository.uploadImage(imageData!, path);
        downloadUrls.add(downloadUrl);
      }
      return downloadUrls.join(',');
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<String> uploadProfileImage(Uint8List imageData, String uid) async {
    try {
      const uuid = Uuid();
      final imageId = uuid.v4();
      String path = 'users/$uid/profile-image/$imageId';
      final downloadUrl = await _imageRepository.uploadImage(imageData, path);
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteProfileImage(String downloadUrl) async {
    try {
      await _imageRepository.deleteImageFromDownloadUrl(downloadUrl);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}
