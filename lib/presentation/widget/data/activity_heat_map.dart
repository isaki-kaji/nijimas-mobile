import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/color.dart';

class ActivityHeatMap extends StatelessWidget {
  const ActivityHeatMap(
      {super.key,
      required this.activities,
      required this.year,
      required this.month,
      required this.isNumbers});

  final List<dynamic> activities;
  final bool isNumbers;
  final String year;
  final String month;

  @override
  Widget build(BuildContext context) {
    final String firstDay = '0$year-0$month-01';
    final firstDayOfWeek = DateTime.parse(firstDay).weekday;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Mon"), Text("Sun")],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: activities.length + firstDayOfWeek - 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1.0, // 正方形のアイテム
              ),
              itemBuilder: (context, index) {
                return (index < firstDayOfWeek - 1)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          print(activities[index - firstDayOfWeek + 1]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isNumbers
                                ? MyColors.getActivityNumbersColor(
                                    activities[index - firstDayOfWeek + 1])
                                : MyColors.getActivityAmountsColor(
                                    activities[index - firstDayOfWeek + 1]),
                            border: Border.all(
                              color: Colors.black, // ボーダーの色
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      );
              }),
        ],
      ),
    );
  }
}
