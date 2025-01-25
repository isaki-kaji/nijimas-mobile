// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowRequest _$FollowRequestFromJson(Map<String, dynamic> json) =>
    FollowRequest(
      requestId: json['requestId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$FollowRequestToJson(FollowRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'uid': instance.uid,
      'username': instance.username,
      'profileImageUrl': instance.profileImageUrl,
    };
