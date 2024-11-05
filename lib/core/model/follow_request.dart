import 'package:json_annotation/json_annotation.dart';

part 'follow_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FollowRequest {
  final String requestId;
  final String uid;
  final String username;
  final String? profileImageUrl;

  const FollowRequest(
      {required this.requestId,
      required this.uid,
      required this.username,
      this.profileImageUrl});

  factory FollowRequest.fromJson(Map<String, dynamic> json) =>
      _$FollowRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FollowRequestToJson(this);
}
