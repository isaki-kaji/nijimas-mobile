// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      mainCategory: json['mainCategory'] as String,
      subCategory: json['subCategory'] as String?,
      subCategory2: json['subCategory2'] as String?,
      postText: json['postText'] as String?,
      photoUrl: json['photoUrl'] as String?,
      expense: (json['expense'] as num?)?.toInt(),
      location: json['location'] as String?,
      publicTypeNo: json['publicTypeNo'] as String,
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'uid': instance.uid,
      'username': instance.username,
      'mainCategory': instance.mainCategory,
      'subCategory': instance.subCategory,
      'subCategory2': instance.subCategory2,
      'postText': instance.postText,
      'photoUrl': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'publicTypeNo': instance.publicTypeNo,
    };
