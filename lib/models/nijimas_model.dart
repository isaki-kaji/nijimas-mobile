import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Nijimas {
  String nijimasId;
  String uid;
  GeoPoint geoPoint;
  String section;
  List<String> photos;
  DateTime createdAt;
  bool isWithinADay;
  Nijimas({
    required this.nijimasId,
    required this.uid,
    required this.geoPoint,
    required this.section,
    required this.photos,
    required this.createdAt,
    required this.isWithinADay,
  });

  Nijimas copyWith({
    String? nijimasId,
    String? uid,
    GeoPoint? geoPoint,
    String? section,
    List<String>? photos,
    DateTime? createdAt,
    bool? isWithinADay,
  }) {
    return Nijimas(
      nijimasId: nijimasId ?? this.nijimasId,
      uid: uid ?? this.uid,
      geoPoint: geoPoint ?? this.geoPoint,
      section: section ?? this.section,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      isWithinADay: isWithinADay ?? this.isWithinADay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nijimasId': nijimasId,
      'uid': uid,
      'geoPoint': {
        'latitude': geoPoint.latitude,
        'longitude': geoPoint.longitude,
      },
      'section': section,
      'photos': photos,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isWithinADay': isWithinADay,
    };
  }

  factory Nijimas.fromMap(Map<String, dynamic> map) {
    return Nijimas(
      nijimasId: map['nijimasId'] ?? '',
      uid: map['uid'] ?? '',
      section: map['section'] ?? '',
      geoPoint: GeoPoint(
        map['geoPoint']['latitude'] as double,
        map['geoPoint']['longitude'] as double,
      ),
      photos: List<String>.from(map['photos']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      isWithinADay: map['isWithinADay'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Nijimas.fromJson(String source) =>
      Nijimas.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Nijimas(nijimasId: $nijimasId, uid: $uid, geoPoint: $geoPoint, section: $section, photos: $photos, createdAt: $createdAt, isWithinADay: $isWithinADay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nijimas &&
        other.nijimasId == nijimasId &&
        other.uid == uid &&
        other.geoPoint == geoPoint &&
        other.section == section &&
        listEquals(other.photos, photos) &&
        other.createdAt == createdAt &&
        other.isWithinADay == isWithinADay;
  }

  @override
  int get hashCode {
    return nijimasId.hashCode ^
        uid.hashCode ^
        geoPoint.hashCode ^
        section.hashCode ^
        photos.hashCode ^
        createdAt.hashCode ^
        isWithinADay.hashCode;
  }
}
