import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateUserRequest {
  final String uid;
  final String? username;
  final String? selfIntro;
  final String? profileImageUrl;
  final String? bannerImageUrl;
  const UpdateUserRequest(
      {required this.uid,
      this.username,
      this.selfIntro,
      this.profileImageUrl,
      this.bannerImageUrl});
  Map<String, Object?> toJson() => _$UpdateUserRequestToJson(this);
}
