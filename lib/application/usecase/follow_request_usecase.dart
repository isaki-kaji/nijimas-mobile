import 'package:nijimas/core/model/follow_request.dart';
import 'package:nijimas/core/request/toggle_follow_request.dart';
import 'package:nijimas/repository/follow_request_repository.dart';

class FollowRequestUsecase {
  final FollowRequestRepository _followRequestRepository;

  FollowRequestUsecase(
      {required FollowRequestRepository followRequestRepository})
      : _followRequestRepository = followRequestRepository;

  Future<void> doFollowRequest(ToggleFollowRequest request) async =>
      _followRequestRepository.doFollowRequest(request);

  Future<void> deleteFollowRequest(ToggleFollowRequest request) async =>
      _followRequestRepository.deleteFollowRequest(request);

  Future<void> handleFollowRequest(String status) async =>
      _followRequestRepository.handleFollowRequest(status);

  Future<List<FollowRequest>> getFollowRequests() async =>
      _followRequestRepository.getFollowRequests();
}
