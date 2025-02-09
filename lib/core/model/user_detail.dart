import 'package:json_annotation/json_annotation.dart';
import 'package:nijimas/core/model/user_top_subcategory.dart';

part 'user_detail.g.dart';

@JsonSerializable()
class UserDetail {
  final String uid;
  final String username;
  final String? selfIntro;
  final String? profileImageUrl;
  final String followingStatus;
  final String followingCount;
  final String followersCount;
  final String postCount;
  final List<UserTopSubCategory> userFavoriteSubcategories;

  const UserDetail(
      {required this.uid,
      required this.username,
      this.selfIntro,
      this.profileImageUrl,
      required this.followingStatus,
      required this.followingCount,
      required this.followersCount,
      required this.postCount,
      required this.userFavoriteSubcategories});

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);

  UserDetail copyWith({
    String? uid,
    String? username,
    String? selfIntro,
    String? profileImageUrl,
    int? version,
    String? followingStatus,
    String? followingCount,
    String? followersCount,
    String? postCount,
    List<UserTopSubCategory>? userFavoriteSubcategories,
  }) {
    return UserDetail(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      selfIntro: selfIntro ?? this.selfIntro,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followingStatus: followingStatus ?? this.followingStatus,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      postCount: postCount ?? this.postCount,
      userFavoriteSubcategories:
          userFavoriteSubcategories ?? this.userFavoriteSubcategories,
    );
  }
}
