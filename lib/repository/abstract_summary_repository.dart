import 'package:nijimas/core/model/monthly_summary_presentation.dart';

abstract class AbstractSummaryRepository {
  Future<MonthlySummaryPresentation> getMonthlySummary(
      {required String year, required String month});
}
