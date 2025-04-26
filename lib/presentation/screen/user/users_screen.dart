import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/users_info_provider.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class UsersScreen extends ConsumerWidget {
  final String uid;
  final UserRelationType type;

  const UsersScreen({
    super.key,
    required this.uid,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(usersInfoProvider((uid: uid, type: type))).when(
            data: (users) {
              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SwitchCircleAvatar(
                        radius: 24,
                        imageUrl: user.profileImageUrl,
                      ),
                      title: Text(
                        user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        GoRouter.of(context).push("/profile/${user.uid}");
                      },
                    ),
                  );
                },
              );
            },
            loading: () => const Loader(),
            error: (error, stack) => ErrorMessage(message: l10n.errorOccurred),
          ),
    );
  }
}
