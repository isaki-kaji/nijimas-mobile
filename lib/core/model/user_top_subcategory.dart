import 'package:json_annotation/json_annotation.dart';
import 'package:nijimas/core/model/sub_category.dart';

part 'user_top_subcategory.g.dart';

@JsonSerializable()
class UserTopSubCategory {
  final String categoryNo;
  final String categoryId;
  final String categoryName;

  UserTopSubCategory({
    required this.categoryNo,
    required this.categoryId,
    required this.categoryName,
  });

  factory UserTopSubCategory.fromJson(Map<String, dynamic> json) =>
      _$UserTopSubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$UserTopSubCategoryToJson(this);

  SubCategory toSubCategory() {
    return SubCategory(
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }
}
