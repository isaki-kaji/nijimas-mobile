import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:nijimas/repository/favorite_repository.dart';

class FavoriteUsecase {
  final FavoriteRepository _favoriteRepository;

  FavoriteUsecase({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository;

  Future<void> toggleFavorite(ToggleFavoriteRequest request) async =>
      _favoriteRepository.toggleFavorite(request);
}
