// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculated_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculatedSummary _$CalculatedSummaryFromJson(Map<String, dynamic> json) =>
    CalculatedSummary(
      categoryName: json['categoryName'] as String,
      count: json['count'] as int,
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$CalculatedSummaryToJson(CalculatedSummary instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'count': instance.count,
      'amount': instance.amount,
      'percentage': instance.percentage,
    };
