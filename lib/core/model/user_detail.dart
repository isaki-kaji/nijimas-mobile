import 'package:json_annotation/json_annotation.dart';

part 'user_detail.g.dart';

@JsonSerializable()
class UserDetail {
  final String uid;
  final String username;
  final String userCode;
  final String? selfIntro;
  final String? profileImageUrl;
  final String followingStatus;
  final String followingCount;
  final String followersCount;
  final String postCount;
  // final List<UserTopSubCategory> userFavoriteSubcategories;

  const UserDetail({
    required this.uid,
    required this.username,
    required this.userCode,
    this.selfIntro,
    this.profileImageUrl,
    required this.followingStatus,
    required this.followingCount,
    required this.followersCount,
    required this.postCount,
    // required this.userFavoriteSubcategories
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);

  UserDetail copyWith({
    String? uid,
    String? username,
    String? userCode,
    String? selfIntro,
    String? profileImageUrl,
    String? followingStatus,
    String? followingCount,
    String? followersCount,
    String? postCount,
  }) {
    return UserDetail(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      userCode: userCode ?? this.userCode,
      selfIntro: selfIntro ?? this.selfIntro,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followingStatus: followingStatus ?? this.followingStatus,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      postCount: postCount ?? this.postCount,
    );
  }
}
