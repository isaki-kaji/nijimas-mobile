import 'package:nijimas/core/model/sub_category.dart';
import 'package:nijimas/core/provider/repository/sub_category_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_used_subcategories_provider.g.dart';

@riverpod
Future<List<SubCategory>> userUsedSubCategories(
    UserUsedSubCategoriesRef ref) async {
  return await ref
      .read(subCategoryRepositoryProvider)
      .getUserUsedSubCategories();
}
