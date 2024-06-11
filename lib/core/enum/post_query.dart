enum PostQueryType {
  uid,
  mainCategory,
}

enum PostQueryKey {
  uid,
  mainCategory,
}

class PostQuery {
  final PostQueryType type;
  final Map<PostQueryKey, dynamic> params;

  PostQuery({
    required this.type,
    required this.params,
  });
}
