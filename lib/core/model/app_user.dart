import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String uid;
  final String username;
  final String userCode;
  final String? profileImageUrl;
  final String? selfIntro;
  final String? countryCode;
  final int version;

  const AppUser({
    required this.uid,
    required this.username,
    required this.userCode,
    this.profileImageUrl,
    this.selfIntro,
    this.countryCode,
    required this.version,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
