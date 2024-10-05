// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_presentation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlySummaryPresentation _$MonthlySummaryPresentationFromJson(
        Map<String, dynamic> json) =>
    MonthlySummaryPresentation(
      uid: json['uid'] as String,
      year: json['year'] as int,
      month: json['month'] as int,
      expenseSummary: (json['expense_summary'] as List<dynamic>)
          .map((e) => CalculatedSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      subcategorySummary: (json['subcategory_summary'] as List<dynamic>)
          .map((e) => CalculatedSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyCount:
          (json['daily_count'] as List<dynamic>).map((e) => e as int).toList(),
      dailyAmount: (json['daily_amount'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$MonthlySummaryPresentationToJson(
        MonthlySummaryPresentation instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'year': instance.year,
      'month': instance.month,
      'expense_summary': instance.expenseSummary,
      'subcategory_summary': instance.subcategorySummary,
      'daily_count': instance.dailyCount,
      'daily_amount': instance.dailyAmount,
    };
