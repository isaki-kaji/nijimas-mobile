import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/own_user_detail_provider.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:nijimas/presentation/widget/common/switch_circle_avatar.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(ownUserDetailProvider).when(data: (data) {
        return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScroll) {
              return [
                _headerSection(data),
              ];
            },
            body: Container());
      }, error: (error, _) {
        return Text(error.toString());
      }, loading: () {
        return const SizedBox();
      }),
    );
  }

  Widget _headerSection(UserResponse user) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 500,
            color: Colors.red,
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
                  const SizedBox(height: 5),
                  Text(user.selfIntro ?? '彼女の笑顔はまるで春の陽射しのように温かく、心を和ませてくれる。'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
