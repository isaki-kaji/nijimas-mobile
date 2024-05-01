import 'dart:typed_data';

abstract class AbstractImageRepository {
  Future<String> uploadImage(Uint8List imageData, String path);
}
