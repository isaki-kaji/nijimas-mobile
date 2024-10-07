// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostRequest _$CreatePostRequestFromJson(Map<String, dynamic> json) =>
    CreatePostRequest(
      postId: json['post_id'] as String,
      uid: json['uid'] as String,
      mainCategory: json['main_category'] as String,
      subCategory1: json['sub_category1'] as String?,
      subCategory2: json['sub_category2'] as String?,
      postText: json['post_text'] as String?,
      photoUrl: json['photo_url'] as String?,
      expense: json['expense'] as String?,
      location: json['location'] as String?,
      publicTypeNo: json['public_type_no'] as String,
    );

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'uid': instance.uid,
      'main_category': instance.mainCategory,
      'sub_category1': instance.subCategory1,
      'sub_category2': instance.subCategory2,
      'post_text': instance.postText,
      'photo_url': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'public_type_no': instance.publicTypeNo,
    };
