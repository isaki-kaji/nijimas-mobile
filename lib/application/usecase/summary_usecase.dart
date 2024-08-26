import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/model/monthly_summary_presentation.dart';
import 'package:nijimas/repository/summary_repository.dart';

class SummaryUsecase {
  final SummaryRepository _summaryRepository;

  SummaryUsecase(
      {required SummaryRepository summaryRepository, required Ref ref})
      : _summaryRepository = summaryRepository;

  Future<MonthlySummaryPresentation> getMonthlySummary(
      {required String year, required String month}) async {
    try {
      return await _summaryRepository.getMonthlySummary(
          year: year, month: month);
    } catch (e) {
      rethrow;
    }
  }
}
