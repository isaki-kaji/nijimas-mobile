// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      uid: json['uid'] as String,
      username: json['username'] as String,
      selfIntro: json['selfIntro'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      followingStatus: json['followingStatus'] as String,
      followingCount: json['followingCount'] as String,
      followersCount: json['followersCount'] as String,
      postCount: json['postCount'] as String,
      userFavoriteSubcategories: (json['userFavoriteSubcategories']
              as List<dynamic>)
          .map((e) => UserTopSubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'selfIntro': instance.selfIntro,
      'profileImageUrl': instance.profileImageUrl,
      'followingStatus': instance.followingStatus,
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
      'postCount': instance.postCount,
      'userFavoriteSubcategories': instance.userFavoriteSubcategories,
    };
