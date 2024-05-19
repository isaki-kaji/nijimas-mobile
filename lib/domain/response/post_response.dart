import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PostResponse {
  final String postId;
  final String uid;
  final String username;
  final String mainCategory;
  final String? subCategory1;
  final String? subCategory2;
  final String? postText;
  final List<String> photoUrl;
  final int? expense;
  final String? location;
  final String publicTypeNo;

  const PostResponse({
    required this.postId,
    required this.uid,
    required this.username,
    required this.mainCategory,
    this.subCategory1,
    this.subCategory2,
    this.postText,
    required this.photoUrl,
    this.expense,
    this.location,
    required this.publicTypeNo,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
