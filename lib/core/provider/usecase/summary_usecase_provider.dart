import 'package:nijimas/application/usecase/summary_usecase.dart';
import 'package:nijimas/core/provider/repository/summary_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'summary_usecase_provider.g.dart';

@riverpod
SummaryUsecase summaryUsecase(SummaryUsecaseRef ref) {
  return SummaryUsecase(
      summaryRepository: ref.read(summaryRepositoryProvider), ref: ref);
}
