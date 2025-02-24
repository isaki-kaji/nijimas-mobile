import 'dart:typed_data';

import 'package:nijimas/repository/image_repository.dart';
import 'package:uuid/uuid.dart';

class ImageUsecase {
  final ImageRepository _imageRepository;

  ImageUsecase({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<List<String>> uploadPostImages(
      List<Uint8List?> imagesData, String uid, String postId) async {
    try {
      const uuid = Uuid();

      List<Future<String>> uploadTasks = imagesData.map((imageData) {
        final imageId = uuid.v4();
        String path = 'posts/$uid/$postId/$imageId';

        return _imageRepository.uploadImage(imageData!, path);
      }).toList();

      List<String> downloadUrls = await Future.wait(uploadTasks);

      return downloadUrls;
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }

  Future<void> deletePostImages(List<String> urls) async {
    for (var url in urls) {
      await _imageRepository.deleteImageFromDownloadUrl(url);
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
    await _imageRepository.deleteImageFromDownloadUrl(downloadUrl);
  }
}
