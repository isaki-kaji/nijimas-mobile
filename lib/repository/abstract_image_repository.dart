import 'dart:typed_data';

abstract class AbstractImageRepository {
  Future<void> uploadImage(Uint8List imageData, String path);
}
