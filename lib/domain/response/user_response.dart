import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String uid;
  final String username;
  final String? selfIntro;
  final String? profileImageUrl;
  final String? bannerImageUrl;
  final String? countryCode;

  const UserResponse(
      {required this.uid,
      required this.username,
      this.selfIntro,
      this.profileImageUrl,
      this.bannerImageUrl,
      this.countryCode});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
