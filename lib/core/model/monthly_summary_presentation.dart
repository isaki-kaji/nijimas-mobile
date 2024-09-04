import 'package:json_annotation/json_annotation.dart';
import 'package:nijimas/core/model/calculated_summary.dart';

part 'monthly_summary_presentation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MonthlySummaryPresentation {
  final String uid;
  final int year;
  final int month;
  final Map<String, CalculatedSummary> expenseSummary;
  final Map<String, CalculatedSummary> subcategorySummary;
  final List<int> dailyNumbers;
  final List<double> dailyAmounts;

  const MonthlySummaryPresentation({
    required this.uid,
    required this.year,
    required this.month,
    required this.expenseSummary,
    required this.subcategorySummary,
    required this.dailyNumbers,
    required this.dailyAmounts,
  });

  factory MonthlySummaryPresentation.fromJson(Map<String, dynamic> json) =>
      _$MonthlySummaryPresentationFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlySummaryPresentationToJson(this);
}
