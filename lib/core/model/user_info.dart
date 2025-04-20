import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String uid;
  final String username;
  final String? profileImageUrl;

  const UserInfo({
    required this.uid,
    required this.username,
    this.profileImageUrl,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo copyWith({
    String? uid,
    String? username,
    String? profileImageUrl,
  }) {
    return UserInfo(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
