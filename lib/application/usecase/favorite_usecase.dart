import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:nijimas/repository/favorite_repository.dart';

class FavoriteUsecase {
  final FavoriteRepository _favoriteRepository;
  final PostsNotifier _postsNotifier;

  FavoriteUsecase(
      {required FavoriteRepository favoriteRepository,
      required PostsNotifier postsNotifier})
      : _favoriteRepository = favoriteRepository,
        _postsNotifier = postsNotifier;

  Future<void> toggleFavorite(
      {required String postId, required void Function() onFailure}) async {
    final request = ToggleFavoriteRequest(postId: postId);
    try {
      final isFavorite = await _favoriteRepository.toggleFavorite(request);
      _postsNotifier.toggleFavorite(postId, isFavorite);
    } catch (e) {
      onFailure();
    }
  }
}
