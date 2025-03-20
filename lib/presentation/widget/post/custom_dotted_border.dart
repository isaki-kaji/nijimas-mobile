import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/util/sizing.dart';

class CustomDottedBorder extends StatelessWidget {
  const CustomDottedBorder({
    super.key,
    required this.item,
  });

  final Widget item;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.secondary,
      dashPattern: const [6, 6],
      strokeWidth: 2.0,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12.0),
      child: SizedBox(
        height: Sizing.imageHeight(context),
        width: Sizing.widthByMQ(context, 0.8),
        child: item,
      ),
    );
  }
}
