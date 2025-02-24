// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostRequest _$CreatePostRequestFromJson(Map<String, dynamic> json) =>
    CreatePostRequest(
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      mainCategory: json['mainCategory'] as String,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postText: json['postText'] as String?,
      photoUrl: json['photoUrl'] as String?,
      expense: json['expense'] as String?,
      location: json['location'] as String?,
      publicTypeNo: json['publicTypeNo'] as String,
    );

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'uid': instance.uid,
      'mainCategory': instance.mainCategory,
      'subCategories': instance.subCategories,
      'postText': instance.postText,
      'photoUrl': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'publicTypeNo': instance.publicTypeNo,
    };
