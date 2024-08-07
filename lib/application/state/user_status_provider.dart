import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/provider/repository/user_status_repository_provider.dart';
import 'package:nijimas/core/model/user_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_status_provider.g.dart';

@riverpod
class CurrentUserStatus extends _$CurrentUserStatus {
  @override
  Future<UserStatus?> build() async {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) {
      return null;
    }
    return await ref.watch(userStatusRepositoryProvider).getUserStatus(user);
  }

  void set(UserStatus userStatus) {
    state = AsyncValue.data(userStatus);
  }
}
