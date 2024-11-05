// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowRequest _$FollowRequestFromJson(Map<String, dynamic> json) =>
    FollowRequest(
      requestId: json['request_id'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
    );

Map<String, dynamic> _$FollowRequestToJson(FollowRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'uid': instance.uid,
      'username': instance.username,
      'profile_image_url': instance.profileImageUrl,
    };
