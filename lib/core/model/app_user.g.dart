// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      selfIntro: json['selfIntro'] as String?,
      countryCode: json['countryCode'] as String?,
      version: json['version'] as int,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'profileImageUrl': instance.profileImageUrl,
      'selfIntro': instance.selfIntro,
      'countryCode': instance.countryCode,
      'version': instance.version,
    };
