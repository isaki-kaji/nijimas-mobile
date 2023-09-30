// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      profileImagePath: json['profileImagePath'] as String,
      bannerImagePath: json['bannerImagePath'] as String,
      karma: json['karma'] as int,
      following:
          (json['following'] as List<dynamic>).map((e) => e as String).toList(),
      isAuthenticated: json['isAuthenticated'] as bool,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'profileImagePath': instance.profileImagePath,
      'bannerImagePath': instance.bannerImagePath,
      'karma': instance.karma,
      'following': instance.following,
      'isAuthenticated': instance.isAuthenticated,
    };
