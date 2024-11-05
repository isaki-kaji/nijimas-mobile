import 'package:json_annotation/json_annotation.dart';

part 'toggle_follow_request_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleFollowRequestRequest {
  final String followingUid;

  const ToggleFollowRequestRequest({
    required this.followingUid,
  });
  Map<String, Object?> toJson() => _$ToggleFollowRequestRequestToJson(this);
}
