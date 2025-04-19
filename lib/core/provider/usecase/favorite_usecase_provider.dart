import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/application/usecase/favorite_usecase.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/favorite_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_usecase_provider.g.dart';

@Riverpod(keepAlive: true)
FavoriteUsecase favoriteUsecase(FavoriteUsecaseRef ref, PostQuery query) {
  final usecase = FavoriteUsecase(
    ref.read(favoriteRepositoryProvider),
    ref.read(postsNotifierProvider(query).notifier),
  );

  // アプリ終了・invalidate 時に Timer をクリア
  ref.onDispose(() => usecase.dispose());

  return usecase;
}
