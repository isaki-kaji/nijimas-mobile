import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  final String uid;
  final String? username;
  final String? selfIntro;
  final String? profileImageUrl;
  final int version;

  const UpdateUserRequest({
    required this.uid,
    this.username,
    this.selfIntro,
    this.profileImageUrl,
    required this.version,
  });
  Map<String, Object?> toJson() => _$UpdateUserRequestToJson(this);
}
