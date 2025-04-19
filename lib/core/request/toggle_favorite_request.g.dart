// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_favorite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleFavoriteRequest _$ToggleFavoriteRequestFromJson(
        Map<String, dynamic> json) =>
    ToggleFavoriteRequest(
      postId: json['postId'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$ToggleFavoriteRequestToJson(
        ToggleFavoriteRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'isFavorite': instance.isFavorite,
    };
