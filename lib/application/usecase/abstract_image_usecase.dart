import 'dart:typed_data';

abstract class AbstractImageUsecase {
  Future<String> uploadPostImages(List<Uint8List?> imagesData, String path);
}
