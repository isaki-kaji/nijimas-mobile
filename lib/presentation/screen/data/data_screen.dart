import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/data/percentage_pie_chart.dart';
import 'package:nijimas/presentation/widget/data/list_data_view.dart';
import 'package:nijimas/presentation/widget/data/spending_percentage_card.dart';

class DataScreen extends HookConsumerWidget {
  const DataScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(monthlySummaryPresentationProvider("2024", "8")).when(
          data: (data) {
            final Map<MainCategory, double> expensePercentages =
                data.expenseSummary.map((key, value) =>
                    MapEntry(MainCategory.fromName(key), value.percentage));
            final Map<MainCategory, double> expenseAmounts = data.expenseSummary
                .map((key, value) =>
                    MapEntry(MainCategory.fromName(key), value.amount));
            final int totalAmounts =
                expenseAmounts.values.reduce((a, b) => a + b).toInt();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                    SpendingPercentageCard(
                      title: '',
                      spendingPercentages: expensePercentages,
                      chart: PercentagePieChart(
                        spendingPercentages: expensePercentages,
                      ),
                      dataView: ListDataView(spendingAmounts: expenseAmounts),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: Loader()),
          error: (error, _) {
            return Center(child: Text('Error: $error'));
          },
        );
  }
}
