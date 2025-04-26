import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/common/not_found_message.dart';
import 'package:nijimas/presentation/widget/notification/notification_tile.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(followRequestsNotifierProvider).when(
        data: (data) {
          return data.isEmpty
              ? NotFoundMessage(
                  message: l10n.noNotification, icon: Icons.notifications_off)
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final followRequest = data[index];
                    return NotificationTile(followRequest: followRequest);
                  },
                );
        },
        error: (error, _) {
          return ErrorMessage(message: l10n.errorOccurred);
        },
        loading: () {
          return const Loader();
        },
      ),
    );
  }
}
