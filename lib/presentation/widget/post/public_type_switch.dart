import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PublicTypeSwitch extends StatelessWidget {
  const PublicTypeSwitch({
    super.key,
    required this.usePublicTypeNo,
  });

  final ValueNotifier<int> usePublicTypeNo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ToggleSwitch(
            initialLabelIndex: usePublicTypeNo.value,
            totalSwitches: 3,
            customWidths: const [80, 200, 80],
            customTextStyles: const [TextStyle(fontWeight: FontWeight.w500)],
            activeBgColor: const [MyColors.lightGreen],
            inactiveBgColor: Theme.of(context).colorScheme.surfaceVariant,
            labels: const ["公開", "フォロワーにのみ公開", "非公開"],
            onToggle: (i) {
              usePublicTypeNo.value = i!;
            },
          ),
        ),
      ),
    );
  }
}
