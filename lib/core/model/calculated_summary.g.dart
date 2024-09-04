// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculated_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculatedSummary _$CalculatedSummaryFromJson(Map<String, dynamic> json) =>
    CalculatedSummary(
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$CalculatedSummaryToJson(CalculatedSummary instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'percentage': instance.percentage,
    };
