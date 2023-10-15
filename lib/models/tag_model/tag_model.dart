import 'dart:convert';

class Tag {
  String tagName;
  int usageCount;
  DateTime createdAt;

  Tag({
    required this.tagName,
    required this.usageCount,
    required this.createdAt,
  });

  Tag copyWith({
    String? tagName,
    int? usageCount,
    DateTime? createdAt,
  }) {
    return Tag(
      tagName: tagName ?? this.tagName,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tagName': tagName,
      'usageCount': usageCount,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      tagName: map['tagName'] ?? '',
      usageCount: map['usageCount']?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  String toString() =>
      'Tag(tagName: $tagName, usageCount: $usageCount, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag &&
        other.tagName == tagName &&
        other.usageCount == usageCount &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      tagName.hashCode ^ usageCount.hashCode ^ createdAt.hashCode;
}
