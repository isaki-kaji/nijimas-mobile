import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/web.dart';
import 'package:nijimas/repository/abstract_image_repository.dart';

class ImageRepository extends AbstractImageRepository {
  final FirebaseStorage _firebaseStorage;
  final Logger _logger;

  ImageRepository(
      {required FirebaseStorage firebaseStorage, required Logger logger})
      : _firebaseStorage = firebaseStorage,
        _logger = logger;

  @override
  Future<String> uploadImage(Uint8List imageData, String path) async {
    Reference ref = _firebaseStorage.ref().child(path);
    try {
      await ref.putData(imageData);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      _logger.e('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }
}
