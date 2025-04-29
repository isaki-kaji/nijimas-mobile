import 'dart:async';

import 'package:nijimas/application/state/posts_map_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:nijimas/repository/favorite_repository.dart';

class FavoriteUsecase {
  final FavoriteRepository _repository;
  final PostsMapNotifier _notifier;

  final Map<String, Timer> _timers = {};
  final Map<String, bool> _lastStates = {};

  FavoriteUsecase(this._repository, this._notifier);

  void toggleFavorite({
    required PostQuery query,
    required String postId,
    required bool isFavorite,
    required void Function() onFailure,
  }) {
    _notifier.toggleFavorite(postId, query);
    _lastStates[postId] = isFavorite;

    _timers[postId]?.cancel();

    _timers[postId] = Timer(const Duration(seconds: 1), () async {
      final latest = _lastStates[postId];
      if (latest == null) return;

      //　状態が変わっていない場合にリクエストを送らない処理を入れたい

      final request = ToggleFavoriteRequest(
        postId: postId,
        isFavorite: !latest,
      );

      try {
        await _repository.toggleFavorite(request);
      } catch (_) {
        _notifier.toggleFavorite(postId, query);
        onFailure();
      } finally {
        _timers.remove(postId);
        _lastStates.remove(postId);
      }
    });
  }

  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    _lastStates.clear();
  }
}
