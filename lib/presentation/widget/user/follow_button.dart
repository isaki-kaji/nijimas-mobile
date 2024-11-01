import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/core/constant/following_status_constant.dart';
import 'package:nijimas/core/request/toggle_follow_request.dart';
import 'package:nijimas/core/theme/color.dart';

class FollowButton extends ConsumerWidget {
  const FollowButton({
    super.key,
    required this.uid,
    required this.followingStatus,
  });
  final String uid;
  final String followingStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownUid = ref.watch(authStateProvider).value!.uid;
    return uid != ownUid
        ? _buildFollowButton(context, ref)
        : const SizedBox.shrink();
  }

  Widget _buildFollowButton(BuildContext context, WidgetRef ref) {
    final userDetailNotifier =
        ref.read(userDetailNotifierProvider(uid).notifier);
    final request = ToggleFollowRequest(followingUid: uid);
    if (followingStatus == FollowingStatusConstant.notFollowing) {
      return OutlinedButton(
        onPressed: () {
          userDetailNotifier.toggleFollowRequest(request);
        },
        child: const Text(
          'フォロー',
        ),
      );
    }

    if (followingStatus == FollowingStatusConstant.following) {
      return OutlinedButton(
        onPressed: () {
          userDetailNotifier.toggleFollowRequest(request);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: MyColors.pink.withOpacity(0.8),
        ),
        child: const Text(
          'フォロー中',
          style: TextStyle(color: MyColors.white),
        ),
      );
    }

    return OutlinedButton(
      onPressed: () {
        userDetailNotifier.toggleFollowRequest(request);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: MyColors.pink,
        side: const BorderSide(color: MyColors.pink, width: 1),
      ),
      child: const Text(
        'フォロー申請中',
      ),
    );
  }
}
