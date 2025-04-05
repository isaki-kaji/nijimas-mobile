import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';

class OtherScreen extends ConsumerWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          const _SectionTitle(title: 'このアプリについて'),
          const ListTile(
            leading: Icon(Icons.description),
            title: Text("利用規約"),
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("プライバシーポリシー"),
          ),
          const Divider(),
          const _SectionTitle(title: 'サポート'),
          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("ヘルプ"),
          ),
          const Divider(),
          const _SectionTitle(title: 'アカウント'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "ログアウト",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => ref.read(authUsecaseProvider).signOut(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
