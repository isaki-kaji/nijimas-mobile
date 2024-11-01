import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/follow_request_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_request_repository_provider.g.dart';

@riverpod
FollowRequestRepository followRequestRepository(
    FollowRequestRepositoryRef ref) {
  return FollowRequestRepository(logger: ref.read(loggerProvider));
}
