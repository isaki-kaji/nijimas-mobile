import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String postId;
  final String uid;
  final String username;
  final String? profileImageUrl;
  final String mainCategory;
  final String? subCategory1;
  final String? subCategory2;
  final String? postText;
  final List<String> photoUrl;
  final String expense;
  final String? location;
  final bool isFavorite;
  final DateTime createdAt;

  const Post({
    required this.postId,
    required this.uid,
    required this.username,
    this.profileImageUrl,
    required this.mainCategory,
    this.subCategory1,
    this.subCategory2,
    this.postText,
    required this.photoUrl,
    required this.expense,
    this.location,
    required this.isFavorite,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      mainCategory: json['mainCategory'] as String,
      subCategory1: json['subCategory1'] as String?,
      subCategory2: json['subCategory2'] as String?,
      postText: json['postText'] as String?,
      photoUrl: List<String>.from(json['photoUrlList'] ?? []), // 空配列を保証
      expense: json['expense'] as String,
      location: json['location'] as String?,
      isFavorite: json['isFavorite'] as bool,
      createdAt: DateTime.parse(json['createdAt']), // DateTimeに変換
    );
  }

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? postId,
    String? uid,
    String? username,
    String? profileImageUrl,
    String? mainCategory,
    String? subCategory1,
    String? subCategory2,
    String? postText,
    List<String>? photoUrl,
    String? expense,
    String? location,
    String? publicTypeNo,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return Post(
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory1: subCategory1 ?? this.subCategory1,
      subCategory2: subCategory2 ?? this.subCategory2,
      postText: postText ?? this.postText,
      photoUrl: photoUrl ?? this.photoUrl,
      expense: expense ?? this.expense,
      location: location ?? this.location,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
