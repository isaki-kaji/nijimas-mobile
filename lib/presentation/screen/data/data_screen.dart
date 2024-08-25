import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/data/spending_distribution_card.dart';

class DataScreen extends HookConsumerWidget {
  const DataScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(monthlySummaryPresentationProvider("2024", "8")).when(
          data: (data) {
            final Map<MainCategory, double> expenseSummary = data.expenseSummary
                .map((key, value) =>
                    MapEntry(MainCategory.fromName(key), value.percentage));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SpendingDistributionCard(
                    spendingDistribution: expenseSummary,
                  ),
                ],
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
