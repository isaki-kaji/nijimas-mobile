import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/summary_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'summary_repository_provider.g.dart';

@riverpod
SummaryRepository summaryRepository(SummaryRepositoryRef ref) {
  return SummaryRepository(logger: ref.read(loggerProvider));
}
