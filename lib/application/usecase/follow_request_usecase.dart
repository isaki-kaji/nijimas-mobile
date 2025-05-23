import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/core/constant/following_status_constants.dart';
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
    final request = ToggleFollowRequestRequest(targetUid: followingUid);

    try {
      if (followingStatus == FollowingStatusConstants.notFollowing) {
        await _followRequestRepository.doFollowRequest(request);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstants.requested);
      } else if (followingStatus == FollowingStatusConstants.requested) {
        await _followRequestRepository.cancelFollowRequest(followingUid);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstants.notFollowing);
      } else {
        await _followRepository.cancelFollow(request);
        _userDetailNotifier
            .setFollowingStatus(FollowingStatusConstants.notFollowing);
      }
    } catch (e) {
      onFailure();
    }
  }
}
