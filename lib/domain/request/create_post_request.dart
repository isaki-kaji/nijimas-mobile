import 'package:json_annotation/json_annotation.dart';

part 'create_post_request.g.dart';

@JsonSerializable()
class CreatePostRequest {
  final String postId;
  final String uid;
  final String mainCategory;
  final String? subCategory1;
  final String? subCategory2;
  final String? postText;
  final String? photoUrl;
  final int? expense;
  final String? location;
  final String publicTypeNo;
  const CreatePostRequest(
      {required this.postId,
      required this.uid,
      required this.mainCategory,
      this.subCategory1,
      this.subCategory2,
      this.postText,
      this.photoUrl,
      this.expense,
      this.location,
      required this.publicTypeNo});
  Map<String, Object?> toJson() => _$CreatePostRequestToJson(this);
}
