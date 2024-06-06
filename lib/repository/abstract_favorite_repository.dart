import 'package:nijimas/domain/request/toggle_favorite_request.dart';

abstract class AbstractFavoriteRepository {
  Future<void> toggleFavorite(ToggleFavoriteRequest request);
}
