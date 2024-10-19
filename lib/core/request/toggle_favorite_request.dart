import 'package:json_annotation/json_annotation.dart';

part 'toggle_favorite_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleFavoriteRequest {
  final String postId;

  const ToggleFavoriteRequest({
    required this.postId,
  });
  Map<String, Object?> toJson() => _$ToggleFavoriteRequestToJson(this);
}
