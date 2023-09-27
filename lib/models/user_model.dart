import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String profileImagePath;
  final String bannerImagePath;
  final int karma;
  final List<String> following;
  final bool isAuthenticated;

  UserModel(
      {required this.uid,
      required this.name,
      required this.profileImagePath,
      required this.bannerImagePath,
      required this.karma,
      required this.following,
      required this.isAuthenticated});

  UserModel copyWith({
    String? uid,
    String? name,
    String? profileImagePath,
    String? bannerImagePath,
    int? karma,
    List<String>? following,
    bool? isAuthenticated,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      karma: karma ?? this.karma,
      following: following ?? this.following,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profileImagePath': profileImagePath,
      'bannerImagePath': bannerImagePath,
      'karma': karma,
      'following': following,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      profileImagePath: map['profileImagePath'] ?? '',
      bannerImagePath: map['bannerImagePath'] ?? '',
      karma: map['karma']?.toInt() ?? 0,
      following: List<String>.from(map['following']),
      isAuthenticated: map['isAuthenticated'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, profileImagePath: $profileImagePath, bannerImagePath: $bannerImagePath, karma: $karma, following: $following, isAuthenticated: $isAuthenticated)';
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
        listEquals(other.following, following) &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        profileImagePath.hashCode ^
        bannerImagePath.hashCode ^
        karma.hashCode ^
        following.hashCode ^
        isAuthenticated.hashCode;
  }
}
