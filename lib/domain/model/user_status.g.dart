// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatusImpl _$$UserStatusImplFromJson(Map<String, dynamic> json) =>
    _$UserStatusImpl(
      uid: json['uid'] as String,
      isFirstSignIn: json['isFirstSignIn'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserStatusImplToJson(_$UserStatusImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'isFirstSignIn': instance.isFirstSignIn,
      'createdAt': instance.createdAt.toIso8601String(),
    };
