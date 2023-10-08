import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  String postId;
  String nijimasId;
  String uid;
  GeoPoint geoPoint;
  String section;
  String? text;
  List<String> imageUrls;
  List<String> favoriteUids;
  int favoriteCount;
  bool isPublic;
  List<String> tags;
  DateTime createdAt;
  Post({
    required this.postId,
    required this.nijimasId,
    required this.uid,
    required this.geoPoint,
    required this.section,
    this.text,
    required this.imageUrls,
    required this.favoriteUids,
    required this.favoriteCount,
    required this.isPublic,
    required this.tags,
    required this.createdAt,
  });

  Post copyWith({
    String? postId,
    String? nijimasId,
    String? uid,
    GeoPoint? geoPoint,
    String? section,
    ValueGetter<String?>? text,
    List<String>? imageUrls,
    List<String>? favoriteUids,
    int? favoriteCount,
    bool? isPublic,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return Post(
      postId: postId ?? this.postId,
      nijimasId: nijimasId ?? this.nijimasId,
      uid: uid ?? this.uid,
      geoPoint: geoPoint ?? this.geoPoint,
      section: section ?? this.section,
      text: text != null ? text() : this.text,
      imageUrls: imageUrls ?? this.imageUrls,
      favoriteUids: favoriteUids ?? this.favoriteUids,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      isPublic: isPublic ?? this.isPublic,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'nijimasId': nijimasId,
      'uid': uid,
      'geoPoint': {
        'latitude': geoPoint.latitude,
        'longitude': geoPoint.longitude,
      },
      'section': section,
      'text': text,
      'imageUrls': imageUrls,
      'favoriteUids': favoriteUids,
      'favoriteCount': favoriteCount,
      'isPublic': isPublic,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      nijimasId: map['nijimasId'] ?? '',
      uid: map['uid'] ?? '',
      geoPoint: GeoPoint(
        map['geoPoint']['latitude'] as double,
        map['geoPoint']['longitude'] as double,
      ),
      section: map['section'] ?? '',
      text: map['text'],
      imageUrls: List<String>.from(map['imageUrls']),
      favoriteUids: List<String>.from(map['favoriteUids']),
      favoriteCount: map['favoriteCount']?.toInt() ?? 0,
      isPublic: map['isPublic'] ?? false,
      tags: List<String>.from(map['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, nijimasId: $nijimasId, uid: $uid, geoPoint: $geoPoint, section: $section, text: $text, imageUrls: $imageUrls, favoriteUids: $favoriteUids, favoriteCount: $favoriteCount, isPublic: $isPublic, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postId == postId &&
        other.nijimasId == nijimasId &&
        other.uid == uid &&
        other.geoPoint == geoPoint &&
        other.section == section &&
        other.text == text &&
        listEquals(other.imageUrls, imageUrls) &&
        listEquals(other.favoriteUids, favoriteUids) &&
        other.favoriteCount == favoriteCount &&
        other.isPublic == isPublic &&
        listEquals(other.tags, tags) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        nijimasId.hashCode ^
        uid.hashCode ^
        geoPoint.hashCode ^
        section.hashCode ^
        text.hashCode ^
        imageUrls.hashCode ^
        favoriteUids.hashCode ^
        favoriteCount.hashCode ^
        isPublic.hashCode ^
        tags.hashCode ^
        createdAt.hashCode;
  }
}
