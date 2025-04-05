import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';

class OtherScreen extends ConsumerWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.aboutApp),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(l10n.termsOfService),
            onTap: () => GoRouter.of(context).push("/terms"),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(l10n.privacyPolicy),
            onTap: () => GoRouter.of(context).push("/privacy"),
          ),
          const Divider(),
          _SectionTitle(title: l10n.support),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(l10n.contact),
          ),
          const Divider(),
          _SectionTitle(title: l10n.account),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              l10n.logout,
              style: const TextStyle(color: Colors.red),
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
