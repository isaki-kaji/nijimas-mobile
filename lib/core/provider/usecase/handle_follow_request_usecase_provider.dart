import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/application/usecase/handle_follow_request_usecase.dart';
import 'package:nijimas/core/provider/repository/follow_request_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'handle_follow_request_usecase_provider.g.dart';

@riverpod
HandleFollowRequestUsecase handleFollowRequestUsecase(
    HandleFollowRequestUsecaseRef ref) {
  return HandleFollowRequestUsecase(
      followRequestRepository: ref.read(followRequestRepositoryProvider),
      followRequestsNotifier:
          ref.read(followRequestsNotifierProvider.notifier));
}
