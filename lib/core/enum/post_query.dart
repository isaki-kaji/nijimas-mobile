import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostQuery &&
        other.type == type &&
        mapEquals(other.params, params);
  }
}
