import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NijimasPost {
  String id;
  String uid;
  GeoPoint geoPoint;
  String? text;
  List<String> imageUrls;
  List<String> favoriteUids;
  int favoriteCount;
  List<String> tags;
  DateTime createdAt;
  NijimasPost({
    required this.id,
    required this.uid,
    required this.geoPoint,
    this.text,
    required this.imageUrls,
    required this.favoriteUids,
    required this.favoriteCount,
    required this.tags,
    required this.createdAt,
  });

  NijimasPost copyWith({
    String? id,
    String? uid,
    GeoPoint? geoPoint,
    String? text,
    List<String>? imageUrls,
    List<String>? favoriteUids,
    int? favoriteCount,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return NijimasPost(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      geoPoint: geoPoint ?? this.geoPoint,
      text: text ?? this.text,
      imageUrls: imageUrls ?? this.imageUrls,
      favoriteUids: favoriteUids ?? this.favoriteUids,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'geoPoint': {
        'latitude': geoPoint.latitude,
        'longitude': geoPoint.longitude,
      },
      'text': text,
      'imageUrls': imageUrls,
      'favoriteUids': favoriteUids,
      'favoriteCount': favoriteCount,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NijimasPost.fromMap(Map<String, dynamic> map) {
    return NijimasPost(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      geoPoint: GeoPoint(
        map['geoPoint']['latitude'] as double,
        map['geoPoint']['longitude'] as double,
      ),
      text: map['text'],
      imageUrls: List<String>.from(map['imageUrls']),
      favoriteUids: List<String>.from(map['favoriteUids']),
      favoriteCount: map['favoriteCount']?.toInt() ?? 0,
      tags: List<String>.from(map['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NijimasPost.fromJson(String source) =>
      NijimasPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, uid: $uid, geoPoint: $geoPoint, text: $text, imageUrls: $imageUrls, favoriteUids: $favoriteUids, favoriteCount: $favoriteCount, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NijimasPost &&
        other.id == id &&
        other.uid == uid &&
        other.geoPoint == geoPoint &&
        other.text == text &&
        listEquals(other.imageUrls, imageUrls) &&
        listEquals(other.favoriteUids, favoriteUids) &&
        other.favoriteCount == favoriteCount &&
        listEquals(other.tags, tags) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        geoPoint.hashCode ^
        text.hashCode ^
        imageUrls.hashCode ^
        favoriteUids.hashCode ^
        favoriteCount.hashCode ^
        tags.hashCode ^
        createdAt.hashCode;
  }
}
