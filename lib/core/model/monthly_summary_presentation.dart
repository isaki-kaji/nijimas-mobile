import 'package:json_annotation/json_annotation.dart';
import 'package:nijimas/core/model/calculated_summary.dart';

part 'monthly_summary_presentation.g.dart';

@JsonSerializable()
class MonthlySummaryPresentation {
  final String uid;
  final int year;
  final int month;
  final List<CalculatedSummary> mainCategorySummary;
  final List<CalculatedSummary> subCategorySummary;
  final List<int> dailyCount;
  final List<double> dailyAmount;

  const MonthlySummaryPresentation({
    required this.uid,
    required this.year,
    required this.month,
    required this.mainCategorySummary,
    required this.subCategorySummary,
    required this.dailyCount,
    required this.dailyAmount,
  });

  factory MonthlySummaryPresentation.fromJson(Map<String, dynamic> json) =>
      _$MonthlySummaryPresentationFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlySummaryPresentationToJson(this);
}
