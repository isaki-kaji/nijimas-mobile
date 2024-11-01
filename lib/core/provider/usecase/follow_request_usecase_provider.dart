import 'package:nijimas/application/usecase/follow_request_usecase.dart';
import 'package:nijimas/core/provider/repository/follow_request_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_request_usecase_provider.g.dart';

@riverpod
FollowRequestUsecase followRequestUsecase(FollowRequestUsecaseRef ref) {
  return FollowRequestUsecase(
    followRequestRepository: ref.read(followRequestRepositoryProvider),
  );
}
