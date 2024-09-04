import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/color.dart';

class ListDataView extends StatelessWidget {
  final Map<MainCategory, double> spendingAmounts;
  const ListDataView({super.key, required this.spendingAmounts});

  @override
  Widget build(BuildContext context) {
    // アイテムごとの高さを設定
    const double itemHeight = 48.0; // 各アイテムの推定高さ (例: 48ピクセル)
    const double maxHeight = 200.0; // 最大の高さ

    // リストの高さを計算
    double calculatedHeight = spendingAmounts.length >= 4
        ? maxHeight
        : spendingAmounts.length * itemHeight;

    return Column(
      children: [
        SizedBox(
          height: calculatedHeight,
          child: ListView.separated(
            shrinkWrap: true,
            physics: spendingAmounts.length >= 4
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(), // 要素数が4つ以上の場合にのみスクロール可能
            itemCount: spendingAmounts.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final entry = spendingAmounts.entries.elementAt(index);
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
                            color: MyColors.getMainCategoryColor(
                                entry.key), // 背景色を設定
                            shape: BoxShape.circle, // 形状を円に設定
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Text(entry.key.getDisplayName(context)),
                      ],
                    ),
                    Text('${entry.value.toInt()} 円'),
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
