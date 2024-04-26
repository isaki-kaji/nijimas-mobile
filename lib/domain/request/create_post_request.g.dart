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
      subCategory1: json['subCategory1'] as String?,
      subCategory2: json['subCategory2'] as String?,
      postText: json['postText'] as String?,
      photoUrl: json['photoUrl'] as String?,
      expense: json['expense'] as int?,
      location: json['location'] as String?,
      publicTypeNo: json['publicTypeNo'] as String,
    );

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'uid': instance.uid,
      'mainCategory': instance.mainCategory,
      'subCategory1': instance.subCategory1,
      'subCategory2': instance.subCategory2,
      'postText': instance.postText,
      'photoUrl': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'publicTypeNo': instance.publicTypeNo,
    };
