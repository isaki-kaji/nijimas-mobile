// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      postId: json['post_id'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      mainCategory: json['main_category'] as String,
      subCategory1: json['sub_category1'] as String?,
      subCategory2: json['sub_category2'] as String?,
      postText: json['post_text'] as String?,
      photoUrl:
          (json['photo_url'] as List<dynamic>).map((e) => e as String).toList(),
      expense: json['expense'] as int?,
      location: json['location'] as String?,
      publicTypeNo: json['public_type_no'] as String,
      isFavorite: json['is_favorite'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'uid': instance.uid,
      'username': instance.username,
      'profile_image_url': instance.profileImageUrl,
      'main_category': instance.mainCategory,
      'sub_category1': instance.subCategory1,
      'sub_category2': instance.subCategory2,
      'post_text': instance.postText,
      'photo_url': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'public_type_no': instance.publicTypeNo,
      'is_favorite': instance.isFavorite,
      'created_at': instance.createdAt.toIso8601String(),
    };
