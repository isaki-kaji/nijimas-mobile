import 'package:firebase_auth/firebase_auth.dart';
import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/application/usecase/user_usecase.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

@riverpod
class AppUser extends _$AppUser {
  @override
  bool build() => false;

  User? getCurrentUser() {
    final auth = ref.read(authUsecaseProvider);
    return auth.currentUser;
  }

  Future<void> createUser(CreateUserRequest request) async {
    final user = ref.read(userUsecaseProvider);
    state = true;
    await user.createUser(request);
    state = false;
  }
}
