import 'package:nijimas/core/request/toggle_follow_request.dart';
import 'package:nijimas/repository/follow_repository.dart';

class FollowUsecase {
  final FollowRepository _followRepository;

  FollowUsecase({required FollowRepository followRepository})
      : _followRepository = followRepository;

  Future<void> toggleFollow(ToggleFollowRequest request) async =>
      _followRepository.toggleFollow(request);
}
