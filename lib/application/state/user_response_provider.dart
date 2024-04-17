import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_response_provider.g.dart';

@riverpod
Future<UserResponse?> userResponse(UserResponseRef ref, String uid) async {
  try {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) {
      return null;
    }
    return await ref.watch(userRepositoryProvider).getUser(uid);
  } catch (e) {
    return null;
  }
}
