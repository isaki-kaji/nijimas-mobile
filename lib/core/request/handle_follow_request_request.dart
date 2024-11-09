import 'package:json_annotation/json_annotation.dart';

part 'handle_follow_request_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HandleFollowRequestRequest {
  final String requestingUid;

  const HandleFollowRequestRequest({
    required this.requestingUid,
  });
  Map<String, Object?> toJson() => _$HandleFollowRequestRequestToJson(this);
}
