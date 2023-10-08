import 'package:cloud_firestore/cloud_firestore.dart';

class NijimasPost {
  String id;
  String uid;
  GeoPoint geoPoint;
  String? text;
  List<String> imageUrls;
  List<String> favoriteUids;
  int favoriteCount;
  bool isPublic;
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
    required this.isPublic,
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
    bool? isPublic,
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
      isPublic: isPublic ?? this.isPublic,
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
      'isPublic': isPublic,
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
      isPublic: map['isPublic'] ?? true,
      tags: List<String>.from(map['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}
