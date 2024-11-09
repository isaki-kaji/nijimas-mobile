import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/core/constant/handle_follow_request_constant.dart';
import 'package:nijimas/core/request/handle_follow_request_request.dart';
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
      {required String uid, required void Function() onFailure}) async {
    final request = HandleFollowRequestRequest(requestingUid: uid);
    try {
      await _followRequestRepository.handleFollowRequest(
          HandleFollowRequestConstant.accept, request);
    } catch (e) {
      onFailure();
    }
    _followRequestsNotifier.remove(uid);
  }

  Future<void> rejectFollowRequest(
      {required String uid, required void Function() onFailure}) async {
    final request = HandleFollowRequestRequest(requestingUid: uid);
    try {
      await _followRequestRepository.handleFollowRequest(
          HandleFollowRequestConstant.reject, request);
    } catch (e) {
      onFailure();
    }
    _followRequestsNotifier.remove(uid);
  }
}
