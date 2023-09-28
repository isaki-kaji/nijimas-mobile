import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/router/navigators.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/cotrollers/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logout(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user!.profileImagePath),
              radius: 70,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          //薄い仕切り線
          const Divider(),
          ListTile(
              title: const Text("My Profile"),
              leading: const Icon(Icons.person),
              onTap: () => Navigators.toUserProfile(context, user.uid)),
          ListTile(
            title: const Text("Log out"),
            leading: Icon(Icons.logout, color: MyColors.redColor),
            onTap: () => logout(ref),
          ),
        ],
      )),
    );
  }
}
