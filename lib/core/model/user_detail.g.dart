// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      uid: json['uid'] as String,
      username: json['username'] as String,
      userCode: json['userCode'] as String,
      selfIntro: json['selfIntro'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      followingStatus: json['followingStatus'] as String,
      followingCount: json['followingCount'] as String,
      followersCount: json['followersCount'] as String,
      postCount: json['postCount'] as String,
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'userCode': instance.userCode,
      'selfIntro': instance.selfIntro,
      'profileImageUrl': instance.profileImageUrl,
      'followingStatus': instance.followingStatus,
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
      'postCount': instance.postCount,
    };
