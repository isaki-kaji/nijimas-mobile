import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/sub_category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sub_category_repository_provider.g.dart';

@riverpod
SubCategoryRepository subCategoryRepository(SubCategoryRepositoryRef ref) {
  return SubCategoryRepository(logger: ref.read(loggerProvider));
}
