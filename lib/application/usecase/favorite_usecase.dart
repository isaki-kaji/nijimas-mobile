import 'package:nijimas/domain/request/toggle_favorite_request.dart';
import 'package:nijimas/repository/abstract_favorite_repository.dart';

class FavoriteUsecase {
  final AbstractFavoriteRepository _favoriteRepository;

  FavoriteUsecase({required AbstractFavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository;

  Future<void> toggleFavorite(ToggleFavoriteRequest request) async =>
      _favoriteRepository.toggleFavorite(request);
}
