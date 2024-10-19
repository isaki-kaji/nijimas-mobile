import 'package:nijimas/application/usecase/follow_usecase.dart';
import 'package:nijimas/core/provider/repository/follow_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_usecase_provider.g.dart';

@riverpod
FollowUsecase followUsecase(FollowUsecaseRef ref) {
  return FollowUsecase(
    followRepository: ref.read(followRepositoryProvider),
  );
}
