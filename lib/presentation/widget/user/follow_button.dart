import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/constant/following_status_constants.dart';
import 'package:nijimas/core/provider/usecase/follow_request_usecase_provider.dart';
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
    final usecase = ref.read(followRequestUsecaseProvider(uid));

    // 状態に応じてテキストとスタイルを設定
    String buttonText;
    ButtonStyle buttonStyle;
    switch (followingStatus) {
      case FollowingStatusConstants.notFollowing:
        buttonText = 'フォロー';
        buttonStyle = OutlinedButton.styleFrom();
        break;
      case FollowingStatusConstants.following:
        buttonText = 'フォロー中';
        buttonStyle = OutlinedButton.styleFrom(
          backgroundColor: MyColors.pink.withOpacity(0.8),
          foregroundColor: MyColors.white,
        );
        break;
      default:
        buttonText = 'フォロー申請中';
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: MyColors.pink,
          side: const BorderSide(color: MyColors.pink, width: 1),
        );
    }

    return OutlinedButton(
      onPressed: () {
        usecase.toggleFollowRequest(
          followingUid: uid,
          followingStatus: followingStatus,
          onFailure: () {},
        );
      },
      style: buttonStyle,
      child: Text(buttonText),
    );
  }
}
