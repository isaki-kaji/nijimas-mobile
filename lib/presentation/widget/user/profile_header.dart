import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/application/state/users_info_provider.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/screen/user/users_screen.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/user/follow_button.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final user = ref.watch(userDetailNotifierProvider(uid));

    return user.when(
      data: (user) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SwitchCircleAvatar(
                        radius: 50,
                        imageUrl: user.profileImageUrl,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(user.postCount.toString(),
                              style: MyTextStyles.body16),
                          const Text("投稿", style: MyTextStyles.body16),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        child: Column(
                          children: [
                            Text(user.followersCount.toString(),
                                style: MyTextStyles.body16),
                            const Text("フォロワー", style: MyTextStyles.body16),
                          ],
                        ),
                        onTap: () {
                          pushWithNavBar(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UsersScreen(
                                uid: uid,
                                type: UserRelationType.followers,
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        child: Column(
                          children: [
                            Text(user.followingCount.toString(),
                                style: MyTextStyles.body16),
                            const Text("フォロー", style: MyTextStyles.body16),
                          ],
                        ),
                        onTap: () {
                          pushWithNavBar(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UsersScreen(
                                uid: uid,
                                type: UserRelationType.followings,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: MyTextStyles.subtitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: user.userCode));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      l10n.copied,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black87,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Text(
                                "@${user.userCode}",
                                style: MyTextStyles.caption.copyWith(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FollowButton(
                        uid: user.uid,
                        followingStatus: user.followingStatus,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (user.selfIntro != null && user.selfIntro!.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          user.selfIntro!,
                          style: MyTextStyles.body14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const Divider(),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ErrorMessage(message: l10n.errorOccurred),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
