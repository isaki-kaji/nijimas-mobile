import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/follow_requests_provider.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/notification/notification_tile.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return ref.watch(followRequestsNotifierProvider).when(
      data: (data) {
        return data.isEmpty
            ? Center(
                child: Text(l10n.noNotification, style: MyTextStyles.body16),
              )
            : ListView.builder(
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
