import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository_provider.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepository(logger: ref.read(loggerProvider));
}
