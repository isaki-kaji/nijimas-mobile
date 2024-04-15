import 'package:json_annotation/json_annotation.dart';

part 'create_user_request.g.dart';

@JsonSerializable()
class CreateUserRequest {
  final String uid;
  final String username;
  final String? countryCode;
  const CreateUserRequest(
      {required this.uid, required this.username, required this.countryCode});
  Map<String, Object?> toJson() => _$CreateUserRequestToJson(this);
}
