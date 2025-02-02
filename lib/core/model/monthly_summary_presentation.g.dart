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
      mainCategorySummary: (json['mainCategorySummary'] as List<dynamic>)
          .map((e) => CalculatedSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategorySummary: (json['subCategorySummary'] as List<dynamic>)
          .map((e) => CalculatedSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyCount:
          (json['dailyCount'] as List<dynamic>).map((e) => e as int).toList(),
      dailyAmount: (json['dailyAmount'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$MonthlySummaryPresentationToJson(
        MonthlySummaryPresentation instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'year': instance.year,
      'month': instance.month,
      'mainCategorySummary': instance.mainCategorySummary,
      'subCategorySummary': instance.subCategorySummary,
      'dailyCount': instance.dailyCount,
      'dailyAmount': instance.dailyAmount,
    };
