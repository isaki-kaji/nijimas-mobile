import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:nijimas/presentation/widget/data/spending_distribution_card.dart';
import 'package:nijimas/presentation/widget/data/top_sub_categories_card.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
  });

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      const SizedBox(height: 5),
                      Text(
                        user.selfIntro ??
                            '彼女の笑顔はまるで春の陽射しのように温かく、心を和ませてくれる。なつかしい記憶がよみがえるような、そんな笑顔を持っている。',
                      ),
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
          ),
        ],
      ),
    );
  }
}
