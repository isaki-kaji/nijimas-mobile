import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/application/usecase/user_status_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_status_provider.g.dart';

@riverpod
class UserStatus extends _$UserStatus {
  @override
  bool build() => false;

  Future<bool> isFirstSignIn() {
    final user = ref.read(authUseCaseProvider).currentUser!;
    return ref.read(userStatusUseCaseProvider).isFirstSignIn(user);
  }
}
