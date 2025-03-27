import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/presentation/widget/home/drawer_list_tile.dart';

class MenuDrawer extends ConsumerWidget {
  final bool isGuestUser;
  const MenuDrawer({super.key, required this.isGuestUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          // const SizedBox(height: 30),
          // SwitchCircleAvatar(
          //   imageUrl: data.profileImageUrl,
          //   radius: 50,
          // ),
          const SizedBox(height: 30),
          ListView(
            //ListViewがアイテム数に合わせて高さを変える
            shrinkWrap: true,
            children: [
              isGuestUser
                  ? const SizedBox.shrink()
                  : DrawerListTile(
                      title: "ユーザー情報",
                      onTap: () {
                        final uid =
                            ref.read(authStateProvider).valueOrNull!.uid;
                        GoRouter.of(context).push("/profile/$uid");
                      }),
              DrawerListTile(
                title: isGuestUser ? "ユーザー登録" : "ログアウト",
                onTap: () => ref.read(authUsecaseProvider).signOut(),
              )
            ],
          ),
        ],
      )),
    );
  }
}
