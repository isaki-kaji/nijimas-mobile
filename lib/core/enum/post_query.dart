import 'package:collection/collection.dart';

enum PostQueryType {
  own,
  timeline,
  favorite,
  uid,
  mainCategory,
  subCategory,
  mainCategoryAndSubCategory,
  ownAndMainCategory,
  ownAndSubCategory,
}

enum PostQueryKey {
  uid,
  mainCategory,
  subCategory,
}

class PostQuery {
  final PostQueryType type;
  final Map<PostQueryKey, String> params;

  static const _equality = MapEquality<PostQueryKey, String>();

  const PostQuery({
    required this.type,
    required this.params,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostQuery) return false;
    return type == other.type && _equality.equals(params, other.params);
  }

  @override
  int get hashCode => type.hashCode ^ _equality.hash(params);

  PostQuery copyWith({
    PostQueryType? type,
    Map<PostQueryKey, String>? params,
  }) {
    return PostQuery(
      type: type ?? this.type,
      params: params ?? Map.of(this.params),
    );
  }

  @override
  String toString() {
    final paramStr =
        params.entries.map((e) => '${e.key.name}:${e.value}').join(', ');
    return 'PostQuery(type: ${type.name}, params: {$paramStr})';
  }
}
