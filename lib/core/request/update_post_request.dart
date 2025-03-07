import 'package:json_annotation/json_annotation.dart';

part 'update_post_request.g.dart';

@JsonSerializable()
class UpdatePostRequest {
  final String uid;
  final String mainCategory;
  final List<String> subCategories;
  final String? postText;
  final String? photoUrl;
  final String? expense;
  final String? location;
  final String publicTypeNo;
  final int version;
  const UpdatePostRequest(
      {required this.uid,
      required this.mainCategory,
      required this.subCategories,
      this.postText,
      this.photoUrl,
      this.expense,
      this.location,
      required this.publicTypeNo,
      required this.version});

  Map<String, dynamic> toJson() => _$UpdatePostRequestToJson(this);
}
