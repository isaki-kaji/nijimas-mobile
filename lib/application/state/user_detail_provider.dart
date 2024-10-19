import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/core/provider/usecase/follow_usecase_provider.dart';
import 'package:nijimas/core/provider/usecase/user_usecase_provider.dart';
import 'package:nijimas/core/request/toggle_follow_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_detail_provider.g.dart';

@riverpod
class UserDetailNotifier extends _$UserDetailNotifier {
  @override
  Future<UserDetail> build(String uid) async {
    try {
      final userUsecase = ref.read(userUsecaseProvider);
      return await userUsecase.getUser(uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFollow(ToggleFollowRequest request) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedUserDetail = currentState.copyWith(
      isFollowing: !currentState.isFollowing,
      followersCount: !currentState.isFollowing
          ? currentState.followersCount + 1
          : currentState.followersCount - 1,
    );
    state = AsyncValue.data(updatedUserDetail);

    try {
      await ref.read(followUsecaseProvider).toggleFollow(request);
    } catch (e) {
      // 失敗した場合のロールバック
      state = AsyncValue.data(currentState);
      rethrow;
    }
  }
}
