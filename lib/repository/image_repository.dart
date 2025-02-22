import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/web.dart';

class ImageRepository {
  final FirebaseStorage _firebaseStorage;
  final Logger _logger;

  ImageRepository(
      {required FirebaseStorage firebaseStorage, required Logger logger})
      : _firebaseStorage = firebaseStorage,
        _logger = logger;

  Future<String> uploadImage(Uint8List imageData, String path) async {
    Reference ref = _firebaseStorage.ref().child(path);
    try {
      await ref.putData(imageData);
      final downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      _logger.e('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteImageFromDownloadUrl(String downloadUrl) async {
    final gsUrl = convertDownloadUrlToGsUrl(downloadUrl);
    final ref = _firebaseStorage.refFromURL(gsUrl);
    await ref.delete();
  }

  /// `downloadUrl` を `gs://` の形式に変換
  String convertDownloadUrlToGsUrl(String downloadUrl) {
    try {
      final Uri uri = Uri.parse(downloadUrl);

      final List<String> segments = uri.pathSegments;
      if (segments.length < 3 || segments[0] != "v0" || segments[1] != "b") {
        throw Exception("Invalid Firebase Storage URL");
      }

      final String bucket = segments[2];

      if (segments.length < 4 || segments[3] != "o") {
        throw Exception("Invalid Firebase Storage path format");
      }

      final String encodedPath = segments.sublist(4).join("/");
      final String decodedPath = Uri.decodeFull(encodedPath);

      return "gs://$bucket/$decodedPath";
    } catch (e) {
      throw Exception("Failed to convert downloadUrl to gsUrl: $e");
    }
  }
}
