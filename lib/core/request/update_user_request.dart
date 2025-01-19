import 'package:json_annotation/json_annotation.dart';
import 'package:nijimas/core/model/user_top_subcategory.dart';

part 'update_user_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateUserRequest {
  final String uid;
  final String? username;
  final String? selfIntro;
  final String? profileImageUrl;
  final List<UserTopSubCategory> userTopSubcategories;

  const UpdateUserRequest({
    required this.uid,
    this.username,
    this.selfIntro,
    this.profileImageUrl,
    required this.userTopSubcategories,
  });
  Map<String, Object?> toJson() => _$UpdateUserRequestToJson(this);
}
