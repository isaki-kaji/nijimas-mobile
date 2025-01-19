// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      uid: json['uid'] as String,
      username: json['username'] as String,
      selfIntro: json['self_intro'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      followingStatus: json['following_status'] as String,
      followingCount: json['following_count'] as int,
      followersCount: json['followers_count'] as int,
      postCount: json['post_count'] as int,
      userTopSubcategories: (json['user_top_subcategories'] as List<dynamic>)
          .map((e) => UserTopSubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'self_intro': instance.selfIntro,
      'profile_image_url': instance.profileImageUrl,
      'following_status': instance.followingStatus,
      'following_count': instance.followingCount,
      'followers_count': instance.followersCount,
      'post_count': instance.postCount,
      'user_top_subcategories': instance.userTopSubcategories,
    };
