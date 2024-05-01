import 'package:nijimas/core/provider/other/firebase_storage_provider.dart';
import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/image_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_repository_provider.g.dart';

@riverpod
ImageRepository imageRepository(ImageRepositoryRef ref) {
  return ImageRepository(
      firebaseStorage: ref.read(firebaseStorageProvider),
      logger: ref.read(loggerProvider));
}
