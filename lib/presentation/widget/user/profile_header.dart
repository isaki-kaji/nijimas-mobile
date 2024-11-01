import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/presentation/widget/user/follow_button.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
  });

  final UserDetail user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    SwitchCircleAvatar(
                      radius: 50,
                      imageUrl: user.profileImageUrl,
                    ),
                    const Spacer(flex: 2),
                    Column(
                      children: [
                        Text(user.postCount.toString(),
                            style: MyTextStyles.body16),
                        const Text("投稿", style: MyTextStyles.body16),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(user.followersCount.toString(),
                            style: MyTextStyles.body16),
                        const Text("フォロワー", style: MyTextStyles.body16),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(user.followingCount.toString(),
                            style: MyTextStyles.body16),
                        const Text("フォロー", style: MyTextStyles.body16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        user.username,
                        style: MyTextStyles.subtitle,
                      ),
                    ),
                    FollowButton(
                      uid: user.uid,
                      followingStatus: user.followingStatus,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                user.selfIntro != null
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(user.selfIntro ?? ""),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                // const SpendingPercentageCard(
                //   spendingPercentages: {
                //     MainCategory.hobbies: 0.4,
                //     MainCategory.food: 0.2,
                //     MainCategory.transport: 0.2,
                //     MainCategory.entertainment: 0.2,
                //   },
                // ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
