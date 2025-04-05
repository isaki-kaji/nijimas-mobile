import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/data/activity_heat_map.dart';
import 'package:nijimas/presentation/widget/data/percentage_pie_chart.dart';
import 'package:nijimas/presentation/widget/data/list_data_view.dart';
import 'package:nijimas/presentation/widget/data/data_card.dart';
import 'package:nijimas/presentation/widget/data/sub_category_cards.dart';

class DataScreen extends HookConsumerWidget {
  final String year;
  final String month;
  const DataScreen({super.key, required this.year, required this.month});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return ref.watch(monthlySummaryPresentationProvider(year, month)).when(
          data: (data) {
            final calculatedExpenseSummary = data.mainCategorySummary;
            final int totalAmounts = calculatedExpenseSummary.isNotEmpty
                ? calculatedExpenseSummary
                    .map((e) => e.amount)
                    .reduce((value, element) => value + element)
                    .toInt()
                : 0;

            final calculatedSubCategorySummary = data.subCategorySummary;

            return Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 50.0),
              child: SingleChildScrollView(
                  child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Expanded(flex: 1, child: Text("合計")),
                      Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(totalAmounts.toString(),
                                style: MyTextStyles.body36),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: Text("　円")),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                DataCard(
                  title: '費目ごとの出費額',
                  chart: PercentagePieChart(summary: calculatedExpenseSummary),
                  dataView: ListDataView(
                    summary: calculatedExpenseSummary,
                  ),
                ),
                const SizedBox(height: 40),
                SubCategoryCards(summary: calculatedSubCategorySummary),
                const SizedBox(height: 40),
                DataCard(
                  title: '日ごとの投稿数',
                  chart: ActivityHeatMap(
                      activities: data.dailyCount,
                      year: year,
                      month: month,
                      isNumbers: true),
                ),
                DataCard(
                  title: '日ごとの出費額',
                  chart: ActivityHeatMap(
                      activities: data.dailyAmount,
                      year: year,
                      month: month,
                      isNumbers: false),
                ),
              ])),
            );
          },
          loading: () => const Center(child: Loader()),
          error: (e, _) {
            return ErrorMessage(message: l10n.errorOccurred);
          },
        );
  }
}
