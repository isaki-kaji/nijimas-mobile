import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/model/follow_request.dart';
import 'package:nijimas/core/provider/usecase/handle_follow_request_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class NotificationTile extends ConsumerWidget {
  const NotificationTile({super.key, required this.followRequest});

  final FollowRequest followRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usecase = ref.read(handleFollowRequestUsecaseProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
              child: Row(
                children: [
                  SwitchCircleAvatar(
                    radius: 30,
                    imageUrl: followRequest.profileImageUrl,
                  ),
                  const SizedBox(width: 15.0),
                  Text(followRequest.username, style: MyTextStyles.subtitle),
                ],
              ),
              onTap: () =>
                  GoRouter.of(context).push("/profile/${followRequest.uid}")),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    await usecase.acceptFollowRequest(
                        uid: followRequest.uid, onFailure: () {});
                  },
                  child: const Text("承認"),
                ),
                const SizedBox(width: 30.0),
                OutlinedButton(
                  onPressed: () async {
                    await usecase.rejectFollowRequest(
                        uid: followRequest.uid, onFailure: () {});
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: MyColors.pink,
                    side: const BorderSide(color: MyColors.pink, width: 1),
                  ),
                  child: const Text("拒否"),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
