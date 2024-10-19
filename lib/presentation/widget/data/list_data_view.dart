import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/model/calculated_summary.dart';
import 'package:nijimas/core/theme/color.dart';

class ListDataView extends StatelessWidget {
  final List<CalculatedSummary> summary;
  const ListDataView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    // アイテムごとの高さを設定
    const double itemHeight = 48.0; // 各アイテムの推定高さ (例: 48ピクセル)
    const double maxHeight = 200.0; // 最大の高さ

    // リストの高さを計算
    double calculatedHeight =
        summary.length >= 4 ? maxHeight : summary.length * itemHeight;

    return Column(
      children: [
        SizedBox(
          height: calculatedHeight,
          child: ListView.separated(
            shrinkWrap: true,
            physics: summary.length >= 4
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(), // 要素数が4つ以上の場合にのみスクロール可能
            itemCount: summary.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final entry = MainCategory.fromName(summary[index].categoryName);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 10,
                          decoration: BoxDecoration(
                            color:
                                MyColors.getMainCategoryColor(entry), // 背景色を設定
                            shape: BoxShape.circle, // 形状を円に設定
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Text(entry.getDisplayName(context)),
                      ],
                    ),
                    Text('${summary[index].amount.toInt()} 円'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
