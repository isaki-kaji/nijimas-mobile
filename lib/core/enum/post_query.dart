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

  PostQuery({
    required this.type,
    required this.params,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostQuery &&
        other.type == type &&
        _equality.equals(other.params, params);
  }

  @override
  int get hashCode => type.hashCode ^ _equality.hash(params);

  PostQuery copyWith({
    PostQueryType? type,
    Map<PostQueryKey, String>? params,
  }) {
    return PostQuery(
      type: type ?? this.type,
      params: params ?? this.params,
    );
  }

  @override
  String toString() => 'PostQuery(type: $type, params: $params)';
}
