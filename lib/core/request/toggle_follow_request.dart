import 'package:json_annotation/json_annotation.dart';

part 'toggle_follow_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleFollowRequest {
  final String followingUid;

  const ToggleFollowRequest({
    required this.followingUid,
  });
  Map<String, Object?> toJson() => _$ToggleFollowRequestToJson(this);
}
