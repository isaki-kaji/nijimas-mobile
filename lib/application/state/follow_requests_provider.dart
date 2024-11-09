import 'package:nijimas/core/model/follow_request.dart';
import 'package:nijimas/core/provider/repository/follow_request_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_requests_provider.g.dart';

@riverpod
class FollowRequestsNotifier extends _$FollowRequestsNotifier {
  @override
  Future<List<FollowRequest>> build() async {
    return await ref.read(followRequestRepositoryProvider).getFollowRequests();
  }

  void remove(String uid) {
    state = state.whenData(
        (requests) => requests.where((element) => element.uid != uid).toList());
  }
}
