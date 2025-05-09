import 'package:json_annotation/json_annotation.dart';

part 'create_post_request.g.dart';

@JsonSerializable()
class CreatePostRequest {
  final String postId;
  final String uid;
  final String mainCategory;
  final List<String>? subCategories;
  final String? postText;
  final String? photoUrl;
  final String? expense;
  final String? location;
  final String publicTypeNo;
  const CreatePostRequest(
      {required this.postId,
      required this.uid,
      required this.mainCategory,
      this.subCategories,
      this.postText,
      this.photoUrl,
      this.expense,
      this.location,
      required this.publicTypeNo});

  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}
