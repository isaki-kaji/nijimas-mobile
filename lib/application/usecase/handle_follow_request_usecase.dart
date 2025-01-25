import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/core/constant/handle_follow_request_constant.dart';
import 'package:nijimas/repository/follow_request_repository.dart';

class HandleFollowRequestUsecase {
  final FollowRequestRepository _followRequestRepository;
  final FollowRequestsNotifier _followRequestsNotifier;

  HandleFollowRequestUsecase({
    required FollowRequestRepository followRequestRepository,
    required FollowRequestsNotifier followRequestsNotifier,
  })  : _followRequestRepository = followRequestRepository,
        _followRequestsNotifier = followRequestsNotifier;

  Future<void> acceptFollowRequest(
      {required String requestId, required void Function() onFailure}) async {
    try {
      await _followRequestRepository.handleFollowRequest(
          requestId, HandleFollowRequestConstant.accept);
    } catch (e) {
      onFailure();
    }
    _followRequestsNotifier.remove(requestId);
  }

  Future<void> rejectFollowRequest(
      {required String requestId, required void Function() onFailure}) async {
    try {
      await _followRequestRepository.handleFollowRequest(
          requestId, HandleFollowRequestConstant.reject);
    } catch (e) {
      onFailure();
    }
    _followRequestsNotifier.remove(requestId);
  }
}
