import 'package:nijimas/core/model/monthly_summary_presentation.dart';
import 'package:nijimas/core/provider/usecase/summary_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthly_summary_provider.g.dart';

@riverpod
Future<MonthlySummaryPresentation> monthlySummaryPresentation(
    MonthlySummaryPresentationRef ref, String year, String month) async {
  final summaryUsecase = ref.read(summaryUsecaseProvider);
  try {
    return summaryUsecase.getMonthlySummary(year: year, month: month);
  } catch (e) {
    rethrow;
  }
}
