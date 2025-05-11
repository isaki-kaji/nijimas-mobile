import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final String firstDay = '$year-${month.toString().padLeft(2, '0')}-01';
    final firstDayOfWeek = DateTime.parse(firstDay).weekday;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final day = index - firstDayOfWeek + 2;
                final date = DateTime(int.parse(year), int.parse(month), day);
                return (index < firstDayOfWeek - 1)
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          _showDetailDialog(
                              context,
                              date,
                              activities[index - firstDayOfWeek + 1].toInt(),
                              isNumbers);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isNumbers
                                ? MyColors.getActivityNumbersColor(
                                    activities[index - firstDayOfWeek + 1])
                                : MyColors.getActivityAmountsColor(
                                    activities[index - firstDayOfWeek + 1]),
                            border: Border.all(
                              color: Colors.black,
                              width: isToday(date) ? 1.5 : 0.5,
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

  void _showDetailDialog(
      BuildContext context, DateTime date, dynamic value, bool isNumber) {
    final dayOfWeek = DateFormat.E('ja').format(date);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${date.month}月 ${date.day}日 ($dayOfWeek)"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isNumber ? "出費回数 : $value 回" : "出費額 : $value 円"),
            ],
          ),
        );
      },
    );
  }

  bool isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }
}
