// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      uid: json['uid'] as String,
      username: json['username'] as String,
      selfIntro: json['self_intro'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      bannerImageUrl: json['banner_image_url'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'self_intro': instance.selfIntro,
      'profile_image_url': instance.profileImageUrl,
      'banner_image_url': instance.bannerImageUrl,
      'country_code': instance.countryCode,
    };
