import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Nijimas {
  String nijimasId;
  String uid;
  GeoPoint geoPoint;
  String section;
  DateTime createdAt;
  Nijimas({
    required this.nijimasId,
    required this.uid,
    required this.geoPoint,
    required this.section,
    required this.createdAt,
  });

  Nijimas copyWith({
    String? nijimasId,
    String? uid,
    GeoPoint? geoPoint,
    String? section,
    DateTime? createdAt,
  }) {
    return Nijimas(
      nijimasId: nijimasId ?? this.nijimasId,
      uid: uid ?? this.uid,
      geoPoint: geoPoint ?? this.geoPoint,
      section: section ?? this.section,
      createdAt: createdAt ?? this.createdAt,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
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
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nijimas.fromJson(String source) =>
      Nijimas.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Nijimas(nijimasId: $nijimasId, uid: $uid, geoPoint: $geoPoint, section: $section, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nijimas &&
        other.nijimasId == nijimasId &&
        other.uid == uid &&
        other.geoPoint == geoPoint &&
        other.section == section &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return nijimasId.hashCode ^
        uid.hashCode ^
        geoPoint.hashCode ^
        section.hashCode ^
        createdAt.hashCode;
  }
}
