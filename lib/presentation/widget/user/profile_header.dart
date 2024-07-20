import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/model/user_profile.dart';
import 'package:nijimas/presentation/widget/data/spending_distribution_card.dart';
import 'package:nijimas/presentation/widget/data/top_sub_categories_card.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
  });

  final UserProfile user;

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
                    const Column(
                      children: [
                        Text("100", style: MyTextStyles.body16),
                        Text("投稿", style: MyTextStyles.body16),
                      ],
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Text("100", style: MyTextStyles.body16),
                        Text("フォロワー", style: MyTextStyles.body16),
                      ],
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Text("100", style: MyTextStyles.body16),
                        Text("フォロー", style: MyTextStyles.body16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      user.username,
                      style: MyTextStyles.subtitle,
                    ),
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
                const SpendingDistributionCard(
                  spendingDistribution: {
                    MainCategory.hobbies: 0.4,
                    MainCategory.food: 0.2,
                    MainCategory.transport: 0.2,
                    MainCategory.entertainment: 0.2,
                  },
                ),
                const SizedBox(height: 10.0),
                const TopSubCategoriesCard(
                    subCategories: ["ラマ", "タスマニアデビル", "ゴールデンターキン"])
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
