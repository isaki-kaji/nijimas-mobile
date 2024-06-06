import 'package:json_annotation/json_annotation.dart';

part 'toggle_favorite_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleFavoriteRequest {
  final String postId;
  final String uid;

  const ToggleFavoriteRequest({
    required this.postId,
    required this.uid,
  });
  Map<String, Object?> toJson() => _$ToggleFavoriteRequestToJson(this);
}
