import 'dart:typed_data';

abstract class AbstractImageUsecase {
  Future<String> uploadImage(List<Uint8List?> imagesData, String path);
}
