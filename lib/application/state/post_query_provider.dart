import 'package:nijimas/core/enum/post_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_query_provider.g.dart';

@riverpod
class PostQueryNotifier extends _$PostQueryNotifier {
  @override
  PostQuery build() {
    return PostQuery(
      type: PostQueryType.own,
      params: {},
    );
  }

  void set(PostQuery postQuery) {
    state = postQuery;
  }

  void reset() {
    state = PostQuery(
      type: PostQueryType.own,
      params: {},
    );
  }
}
