import 'package:json_annotation/json_annotation.dart';

part 'toggle_favorite_request.g.dart';

@JsonSerializable()
class ToggleFavoriteRequest {
  final String postId;
  final bool isFavorite;

  const ToggleFavoriteRequest({required this.postId, required this.isFavorite});
  Map<String, Object?> toJson() => _$ToggleFavoriteRequestToJson(this);
}
