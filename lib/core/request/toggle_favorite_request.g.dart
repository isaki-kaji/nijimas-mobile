// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleFavoriteRequest _$ToggleFavoriteRequestFromJson(
        Map<String, dynamic> json) =>
    ToggleFavoriteRequest(
      postId: json['post_id'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$ToggleFavoriteRequestToJson(
        ToggleFavoriteRequest instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'uid': instance.uid,
    };
