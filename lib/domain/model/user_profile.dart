import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile {
  final String uid;
  final String username;
  final String? selfIntro;
  final String? profileImageUrl;
  final String? bannerImageUrl;
  final String? countryCode;

  const UserProfile(
      {required this.uid,
      required this.username,
      this.selfIntro,
      this.profileImageUrl,
      this.bannerImageUrl,
      this.countryCode});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
