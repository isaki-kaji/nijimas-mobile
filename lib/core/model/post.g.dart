// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      mainCategory: json['mainCategory'] as String,
      publicTypeNo: json['publicTypeNo'] as String,
      subCategory1: json['subCategory1'] as String?,
      subCategory2: json['subCategory2'] as String?,
      postText: json['postText'] as String?,
      photoUrl:
          (json['photoUrl'] as List<dynamic>).map((e) => e as String).toList(),
      expense: json['expense'] as String,
      location: json['location'] as String?,
      isFavorite: json['isFavorite'] as bool,
      favoriteCount: json['favoriteCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      version: json['version'] as int? ?? 1,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'uid': instance.uid,
      'username': instance.username,
      'profileImageUrl': instance.profileImageUrl,
      'mainCategory': instance.mainCategory,
      'publicTypeNo': instance.publicTypeNo,
      'subCategory1': instance.subCategory1,
      'subCategory2': instance.subCategory2,
      'postText': instance.postText,
      'photoUrl': instance.photoUrl,
      'expense': instance.expense,
      'location': instance.location,
      'isFavorite': instance.isFavorite,
      'favoriteCount': instance.favoriteCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'version': instance.version,
    };
