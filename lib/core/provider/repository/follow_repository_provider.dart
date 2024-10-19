import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/follow_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'follow_repository_provider.g.dart';

@riverpod
FollowRepository followRepository(FollowRepositoryRef ref) {
  return FollowRepository(logger: ref.read(loggerProvider));
}
