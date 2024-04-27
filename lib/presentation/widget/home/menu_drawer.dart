import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          TextButton(
              onPressed: () => ref.read(authUsecaseProvider).signOut(),
              child: const Text(
                "ログアウト",
                style: TextStyle(color: Colors.black),
              ))
        ],
      )),
    );
  }
}
