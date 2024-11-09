import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/notification/notification_tile.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(followRequestsNotifierProvider).when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final followRequest = data[index];
            return NotificationTile(followRequest: followRequest);
          },
        );
      },
      error: (error, _) {
        return Text(error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
