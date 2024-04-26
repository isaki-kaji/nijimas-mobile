import 'package:nijimas/application/usecase/post_usecase.dart';
import 'package:nijimas/core/provider/repository/post_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_usecase_provider.g.dart';

@riverpod
PostUsecase postUsecase(PostUsecaseRef ref) {
  return PostUsecase(
      postRepository: ref.read(postRepositoryProvider), ref: ref);
}
