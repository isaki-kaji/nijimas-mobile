import 'package:nijimas/application/usecase/favorite_usecase.dart';
import 'package:nijimas/core/provider/repository/favorite_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_usecase_provider.g.dart';

@riverpod
FavoriteUsecase favoriteUsecase(FavoriteUsecaseRef ref) {
  return FavoriteUsecase(
    favoriteRepository: ref.read(favoriteRepositoryProvider),
  );
}
