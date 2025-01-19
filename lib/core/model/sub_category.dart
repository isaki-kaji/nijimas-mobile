import 'package:json_annotation/json_annotation.dart';

part 'sub_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubCategory {
  final String categoryId;
  final String categoryName;

  const SubCategory({
    required this.categoryId,
    required this.categoryName,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
