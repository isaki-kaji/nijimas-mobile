import 'dart:convert';
import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String profileImagePath;
  final String bannerImagePath;
  final int karma;
  final List<String> following;

  UserModel({
    required this.uid,
    required this.name,
    required this.profileImagePath,
    required this.bannerImagePath,
    required this.karma,
    required this.following,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? profileImageUrl,
    String? bannerImageUrl,
    int? karma,
    List<String>? accompanying,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profileImagePath: profileImageUrl ?? profileImagePath,
      bannerImagePath: bannerImageUrl ?? bannerImagePath,
      karma: karma ?? this.karma,
      following: accompanying ?? following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profileImageUrl': profileImagePath,
      'bannerImageUrl': bannerImagePath,
      'karma': karma,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      profileImagePath: map['profileImageUrl'] ?? '',
      bannerImagePath: map['bannerImageUrl'] ?? '',
      karma: map['karma']?.toInt() ?? 0,
      following: List<String>.from(map['following']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, profileImageUrl: $profileImagePath, bannerImageUrl: $bannerImagePath, karma: $karma, following: $following)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        other.profileImagePath == profileImagePath &&
        other.bannerImagePath == bannerImagePath &&
        other.karma == karma &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        profileImagePath.hashCode ^
        bannerImagePath.hashCode ^
        karma.hashCode ^
        following.hashCode;
  }
}
