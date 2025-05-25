// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      uid: json['uid'] as String,
      username: json['username'] as String?,
      userCode: json['userCode'] as String,
      selfIntro: json['selfIntro'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      version: json['version'] as int,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'userCode': instance.userCode,
      'selfIntro': instance.selfIntro,
      'profileImageUrl': instance.profileImageUrl,
      'version': instance.version,
    };
