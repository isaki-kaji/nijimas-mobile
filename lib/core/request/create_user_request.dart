import 'package:json_annotation/json_annotation.dart';

part 'create_user_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateUserRequest {
  final String uid;
  final String username;

  const CreateUserRequest({required this.uid, required this.username});
  Map<String, Object?> toJson() => _$CreateUserRequestToJson(this);
}
