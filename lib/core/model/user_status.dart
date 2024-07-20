import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_status.freezed.dart';
part 'user_status.g.dart';

@freezed
class UserStatus with _$UserStatus {
  const factory UserStatus({
    required String uid,
    required bool isFirstSignIn,
    required DateTime createdAt,
  }) = _UserStatus;

  factory UserStatus.fromJson(Map<String, dynamic> json) =>
      _$UserStatusFromJson(json);
}
