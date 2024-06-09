enum PostQueryType {
  uid,
}

enum PostQueryKey {
  uid,
}

class PostQuery {
  final PostQueryType type;
  final Map<PostQueryKey, dynamic> params;

  PostQuery({
    required this.type,
    required this.params,
  });
}
