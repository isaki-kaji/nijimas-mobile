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
      expenseSummary: (json['expense_summary'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, CalculatedSummary.fromJson(e as Map<String, dynamic>)),
      ),
      subcategorySummary:
          (json['subcategory_summary'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, CalculatedSummary.fromJson(e as Map<String, dynamic>)),
      ),
      dailyNumbers: (json['daily_numbers'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      dailyAmounts: (json['daily_amounts'] as List<dynamic>)
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
      'daily_numbers': instance.dailyNumbers,
      'daily_amounts': instance.dailyAmounts,
    };
