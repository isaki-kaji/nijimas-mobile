import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/core/constant/following_status_constant.dart';
import 'package:nijimas/core/request/toggle_follow_request_request.dart';
import 'package:nijimas/repository/follow_repository.dart';
import 'package:nijimas/repository/follow_request_repository.dart';

class FollowRequestUsecase {
  final FollowRequestRepository _followRequestRepository;
  final FollowRepository _followRepository;
  final UserDetailNotifier _userDetailNotifier;

  FollowRequestUsecase({
    required FollowRequestRepository followRequestRepository,
    required FollowRepository followRepository,
    required UserDetailNotifier userDetailNotifier,
  })  : _followRequestRepository = followRequestRepository,
        _followRepository = followRepository,
        _userDetailNotifier = userDetailNotifier;

  Future<void> toggleFollowRequest(
      {required String followingUid,
      required String followingStatus,
      required void Function() onFailure}) async {
    final request = ToggleFollowRequestRequest(requestedUid: followingUid);

    try {
      if (followingStatus == FollowingStatusConstant.notFollowing) {
        await _followRequestRepository.doFollowRequest(request);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstant.requested);
      } else if (followingStatus == FollowingStatusConstant.requested) {
        await _followRequestRepository.deleteFollowRequest(request);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstant.notFollowing);
      } else {
        await _followRepository.toggleFollow(request);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstant.notFollowing);
      }
    } catch (e) {
      onFailure();
    }
  }
}
