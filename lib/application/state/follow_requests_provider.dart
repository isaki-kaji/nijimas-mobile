import 'package:nijimas/core/model/follow_request.dart';
import 'package:nijimas/core/provider/usecase/follow_request_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_requests_provider.g.dart';

@riverpod
class FollowRequests extends _$FollowRequests {
  @override
  Future<List<FollowRequest>> build() async {
    return await ref.read(followRequestUsecaseProvider).getFollowRequests();
  }
}
