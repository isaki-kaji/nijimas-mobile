import 'package:nijimas/core/constant/following_status_constant.dart';
import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/core/provider/usecase/follow_request_usecase_provider.dart';
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

  Future<void> toggleFollowRequest(ToggleFollowRequest request) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    UserDetail updatedUserDetail;
    try {
      if (currentState.followingStatus ==
          FollowingStatusConstant.notFollowing) {
        updatedUserDetail = currentState.copyWith(
            followingStatus: FollowingStatusConstant.requested);
        await ref.read(followRequestUsecaseProvider).doFollowRequest(request);
      } else if (currentState.followingStatus ==
          FollowingStatusConstant.following) {
        updatedUserDetail = currentState.copyWith(
            followingStatus: FollowingStatusConstant.notFollowing);
        await ref.read(followUsecaseProvider).toggleFollow(request);
      } else {
        updatedUserDetail = currentState.copyWith(
            followingStatus: FollowingStatusConstant.notFollowing);
        await ref
            .read(followRequestUsecaseProvider)
            .deleteFollowRequest(request);
      }

      state = AsyncValue.data(updatedUserDetail);
    } catch (e) {
      // 失敗した場合のロールバック
      state = AsyncValue.data(currentState);
      rethrow;
    }
  }
}
