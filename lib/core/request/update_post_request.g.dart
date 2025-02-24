// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePostRequest _$UpdatePostRequestFromJson(Map<String, dynamic> json) =>
    UpdatePostRequest(
      uid: json['uid'] as String,
      mainCategory: json['mainCategory'] as String,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      postText: json['postText'] as String?,
      photoUrl: json['photoUrl'] as String?,
      expense: json['expense'] as String?,
      location: json['location'] as String?,
      publicTypeNo: json['publicTypeNo'] as String,
      version: json['version'] as int,
    );

Map<String, dynamic> _$UpdatePostRequestToJson(UpdatePostRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'mainCategory': instance.mainCategory,
      'subCategories': instance.subCategories,
      'postText': instance.postText,
      'photoUrl': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'publicTypeNo': instance.publicTypeNo,
      'version': instance.version,
    };
