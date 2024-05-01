import 'package:nijimas/application/usecase/image_usecase.dart';
import 'package:nijimas/core/provider/repository/image_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_usecase_provider.g.dart';

@riverpod
ImageUsecase imageUsecase(ImageUsecaseRef ref) {
  return ImageUsecase(
    imageRepository: ref.read(imageRepositoryProvider),
  );
}
