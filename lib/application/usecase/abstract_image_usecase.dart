import 'dart:typed_data';

abstract class AbstractImageUsecase {
  Future<void> uploadImage(List<Uint8List?> imagesData, String path);
}
