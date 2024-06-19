import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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
  final int? expense;
  final String? location;
  final String publicTypeNo;
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
    this.expense,
    this.location,
    required this.publicTypeNo,
    required this.isFavorite,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

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
    int? expense,
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
      publicTypeNo: publicTypeNo ?? this.publicTypeNo,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
