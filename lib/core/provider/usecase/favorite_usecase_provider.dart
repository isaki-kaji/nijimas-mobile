import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/application/usecase/favorite_usecase.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/repository/favorite_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_usecase_provider.g.dart';

@riverpod
FavoriteUsecase favoriteUsecase(FavoriteUsecaseRef ref, PostQuery query) {
  return FavoriteUsecase(
    favoriteRepository: ref.read(favoriteRepositoryProvider),
    postsNotifier: ref.read(postsNotifierProvider(query).notifier),
  );
}
