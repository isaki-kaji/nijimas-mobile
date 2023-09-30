import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String uid,
    required String name,
    required String profileImagePath,
    required String bannerImagePath,
    required int karma,
    required List<String> following,
    required bool isAuthenticated,
  }) = _UserModel;

  // fromJsonメソッドを使用してオブジェクトをデシリアライズ
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
