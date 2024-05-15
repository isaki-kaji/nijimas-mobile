import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/domain/response/post_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_by_uid_response.g.dart';

@riverpod
Future<List<PostResponse>> postsByUidResponse(
    PostsByUidResponseRef ref, String uid) async {
  try {
    final postUsecase = ref.read(postUsecaseProvider);
    return await postUsecase.getPostsByUid(uid: uid);
  } catch (e) {
    rethrow;
  }
}
