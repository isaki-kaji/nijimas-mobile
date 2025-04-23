import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/application/usecase/favorite_usecase.dart';
import 'package:nijimas/core/provider/repository/favorite_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_usecase_provider.g.dart';

@Riverpod(keepAlive: true)
FavoriteUsecase favoriteUsecase(FavoriteUsecaseRef ref) {
  final notifier = ref.read(postsMapNotifierProvider.notifier);
  final repository = ref.read(favoriteRepositoryProvider);

  final usecase = FavoriteUsecase(repository, notifier);
  ref.onDispose(() => usecase.dispose());
  return usecase;
}
