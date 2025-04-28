import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/core/model/year_month.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/add_post_button.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/data/activity_heat_map.dart';
import 'package:nijimas/presentation/widget/data/percentage_pie_chart.dart';
import 'package:nijimas/presentation/widget/data/list_data_view.dart';
import 'package:nijimas/presentation/widget/data/data_card.dart';
import 'package:nijimas/presentation/widget/data/sub_category_cards.dart';

class DataScreen extends HookConsumerWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ローカルで year/month を管理
    final useYearMonth = useState(YearMonth.now());
    final l10n = L10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    if (useYearMonth.value.canSubtract()) {
                      useYearMonth.value = useYearMonth.value.subtractMonth();
                    }
                  },
                  icon: const Icon(Icons.arrow_left),
                  iconSize: 24,
                  color: useYearMonth.value.canSubtract()
                      ? MyColors.black
                      : MyColors.lightGrey,
                ),
              ),
            ),
            Text(
              "${useYearMonth.value.year} / ${useYearMonth.value.month}",
              style: const TextStyle(fontSize: 20),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    if (!useYearMonth.value.isCurrent()) {
                      useYearMonth.value = useYearMonth.value.addMonth();
                    }
                  },
                  icon: const Icon(Icons.arrow_right),
                  iconSize: 24,
                  color: useYearMonth.value.isCurrent()
                      ? MyColors.lightGrey
                      : MyColors.black,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ref
          .watch(monthlySummaryPresentationProvider(
              useYearMonth.value.year.toString(),
              useYearMonth.value.month.toString()))
          .when(
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
                      DataCard(
                        title: '費目ごとの出費額',
                        chart: PercentagePieChart(
                            summary: calculatedExpenseSummary),
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
                            year: useYearMonth.value.year.toString(),
                            month: useYearMonth.value.month.toString(),
                            isNumbers: true),
                      ),
                      DataCard(
                        title: '日ごとの出費額',
                        chart: ActivityHeatMap(
                            activities: data.dailyAmount,
                            year: useYearMonth.value.year.toString(),
                            month: useYearMonth.value.month.toString(),
                            isNumbers: false),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: Loader()),
            error: (e, _) {
              return ErrorMessage(message: l10n.errorOccurred);
            },
          ),
      floatingActionButton: const AddPostButton(heroTag: "data"),
    );
  }
}
