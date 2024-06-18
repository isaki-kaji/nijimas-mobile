import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/own_user_detail_provider.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/presentation/widget/common/switch_circle_avatar.dart';
import 'package:nijimas/presentation/widget/home/drawer_list_tile.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(ownUserDetailProvider).when(data: (data) {
      return Drawer(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 30),
            SwitchCircleAvatar(
              imageUrl: data.profileImageUrl,
              radius: 50,
            ),
            const SizedBox(height: 30),
            ListView(
              //ListViewがアイテム数に合わせて高さを変える
              shrinkWrap: true,
              children: [
                DrawerListTile(
                  title: "ユーザー情報",
                  onTap: () => GoRouter.of(context).push("/profile"),
                ),
                DrawerListTile(
                  title: "ログアウト",
                  onTap: () => ref.read(authUsecaseProvider).signOut(),
                )
              ],
            ),
          ],
        )),
      );
    }, error: (error, _) {
      return Text(error.toString());
    }, loading: () {
      return const SizedBox();
    });
  }
}
