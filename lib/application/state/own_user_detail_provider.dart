import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/provider/usecase/user_usecase_provider.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'own_user_detail_provider.g.dart';

@riverpod
Future<UserResponse> ownUserDetail(OwnUserDetailRef ref) {
  final uid = ref.read(authStateProvider).valueOrNull!.uid;
  final userUsecase = ref.read(userUsecaseProvider);
  try {
    return userUsecase.getUser(uid: uid);
  } catch (e) {
    rethrow;
  }
}
