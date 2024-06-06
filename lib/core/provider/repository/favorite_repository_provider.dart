import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/favorite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_repository_provider.g.dart';

@riverpod
FavoriteRepository favoriteRepository(FavoriteRepositoryRef ref) {
  return FavoriteRepository(logger: ref.read(loggerProvider));
}
