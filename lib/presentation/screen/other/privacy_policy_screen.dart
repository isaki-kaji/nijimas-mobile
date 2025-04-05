import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.privacyPolicy, style: MyTextStyles.title),
              const SizedBox(height: 16),
              _buildSection(
                  l10n.privacySection1Title, l10n.privacySection1Body),
              _buildSection(
                  l10n.privacySection2Title, l10n.privacySection2Body),
              _buildSection(
                  l10n.privacySection3Title, l10n.privacySection3Body),
              _buildSection(
                  l10n.privacySection4Title, l10n.privacySection4Body),
              _buildSection(
                  l10n.privacySection5Title, l10n.privacySection5Body),
              _buildSection(
                  l10n.privacySection6Title, l10n.privacySection6Body),
              _buildSection(
                  l10n.privacySection7Title, l10n.privacySection7Body),
              _buildSection(
                  l10n.privacySection8Title, l10n.privacySection8Body),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTextStyles.subtitle),
          const SizedBox(height: 8),
          Text(body, style: MyTextStyles.body14),
        ],
      ),
    );
  }
}
