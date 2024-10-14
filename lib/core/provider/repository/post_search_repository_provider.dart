import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/post_search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_search_repository_provider.g.dart';

@riverpod
PostSearchRepository postSearchRepository(PostSearchRepositoryRef ref) {
  return PostSearchRepository(logger: ref.read(loggerProvider));
}
