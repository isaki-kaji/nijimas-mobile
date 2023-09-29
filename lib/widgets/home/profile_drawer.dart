import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/router/navigators.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/controllers/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logout(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");
    final user = ref.watch(userProvider);
    final isGuest = !user!.isAuthenticated;
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: isGuest
                  ? const AssetImage(Constants.defaultAvatarPath)
                      as ImageProvider<Object>?
                  : NetworkImage(user.profileImagePath),
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
            leading: const Icon(Icons.logout, color: MyColors.pinkColor),
            onTap: () => logout(ref),
          ),
        ],
      )),
    );
  }
}
