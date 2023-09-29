import 'package:flutter/material.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/widgets/home/profile_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");
    final user = ref.watch(userProvider);
    final isGuest = !user!.isAuthenticated;
    return Scaffold(
      appBar: AppBar(actions: [
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: CircleAvatar(
                backgroundImage: isGuest
                    ? const AssetImage(Constants.defaultAvatarPath)
                        as ImageProvider<Object>?
                    : NetworkImage(user.profileImagePath),
              ),
              onPressed: () => showEndDrawer(context),
            ),
          );
        })
      ]),
      endDrawer: const ProfileDrawer(),
      body: Center(
        child: Text(user!.name),
      ),
    );
  }
}
