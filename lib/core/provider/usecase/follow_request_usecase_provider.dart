import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/application/usecase/follow_request_usecase.dart';
import 'package:nijimas/core/provider/repository/follow_repository_provider.dart';
import 'package:nijimas/core/provider/repository/follow_request_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_request_usecase_provider.g.dart';

@riverpod
FollowRequestUsecase followRequestUsecase(
    FollowRequestUsecaseRef ref, String followingUid) {
  return FollowRequestUsecase(
    followRequestRepository: ref.read(followRequestRepositoryProvider),
    followRepository: ref.read(followRepositoryProvider),
    userDetailNotifier:
        ref.watch(userDetailNotifierProvider(followingUid).notifier),
  );
}
