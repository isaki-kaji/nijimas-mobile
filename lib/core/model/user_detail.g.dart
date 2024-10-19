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
      isFollowing: json['is_following'] as bool,
      followingCount: json['following_count'] as int,
      followersCount: json['followers_count'] as int,
      postCount: json['post_count'] as int,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'self_intro': instance.selfIntro,
      'profile_image_url': instance.profileImageUrl,
      'is_following': instance.isFollowing,
      'following_count': instance.followingCount,
      'followers_count': instance.followersCount,
      'post_count': instance.postCount,
    };
