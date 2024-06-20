// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      uid: json['uid'] as String,
      username: json['username'] as String?,
      selfIntro: json['self_intro'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      bannerImageUrl: json['banner_image_url'] as String?,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'self_intro': instance.selfIntro,
      'profile_image_url': instance.profileImageUrl,
      'banner_image_url': instance.bannerImageUrl,
    };
