import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataScreen extends HookConsumerWidget {
  const DataScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("Data Screen"));
  }
}
