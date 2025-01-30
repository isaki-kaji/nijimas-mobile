import 'package:json_annotation/json_annotation.dart';

part 'toggle_follow_request_request.g.dart';

@JsonSerializable()
class ToggleFollowRequestRequest {
  final String targetUid;

  const ToggleFollowRequestRequest({
    required this.targetUid,
  });
  Map<String, Object?> toJson() => _$ToggleFollowRequestRequestToJson(this);
}
