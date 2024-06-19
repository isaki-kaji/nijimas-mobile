// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      uid: json['uid'] as String,
      username: json['username'] as String,
      selfIntro: json['self_intro'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      bannerImageUrl: json['banner_image_url'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'self_intro': instance.selfIntro,
      'profile_image_url': instance.profileImageUrl,
      'banner_image_url': instance.bannerImageUrl,
      'country_code': instance.countryCode,
    };
