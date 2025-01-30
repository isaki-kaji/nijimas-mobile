import 'package:nijimas/core/request/toggle_follow_request_request.dart';
import 'package:nijimas/repository/follow_repository.dart';

class FollowUsecase {
  final FollowRepository _followRepository;

  FollowUsecase({required FollowRepository followRepository})
      : _followRepository = followRepository;

  Future<void> toggleFollow(ToggleFollowRequestRequest request) async =>
      _followRepository.cancelFollow(request);
}
