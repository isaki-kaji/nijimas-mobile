import 'package:json_annotation/json_annotation.dart';

part 'calculated_summary.g.dart';

@JsonSerializable()
class CalculatedSummary {
  final String categoryName;
  final double amount;
  final double percentage;

  CalculatedSummary({
    required this.categoryName,
    required this.amount,
    required this.percentage,
  });

  factory CalculatedSummary.fromJson(Map<String, dynamic> json) =>
      _$CalculatedSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CalculatedSummaryToJson(this);
}
