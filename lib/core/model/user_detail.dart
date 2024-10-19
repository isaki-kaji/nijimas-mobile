import 'package:json_annotation/json_annotation.dart';

part 'user_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserDetail {
  final String uid;
  final String username;
  final String? selfIntro;
  final String? profileImageUrl;
  final bool isFollowing;
  final int followingCount;
  final int followersCount;
  final int postCount;

  const UserDetail(
      {required this.uid,
      required this.username,
      this.selfIntro,
      this.profileImageUrl,
      required this.isFollowing,
      required this.followingCount,
      required this.followersCount,
      required this.postCount});

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);

  UserDetail copyWith({
    String? uid,
    String? username,
    String? selfIntro,
    String? profileImageUrl,
    bool? isFollowing,
    int? followingCount,
    int? followersCount,
    int? postCount,
  }) {
    return UserDetail(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      selfIntro: selfIntro ?? this.selfIntro,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isFollowing: isFollowing ?? this.isFollowing,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      postCount: postCount ?? this.postCount,
    );
  }
}
