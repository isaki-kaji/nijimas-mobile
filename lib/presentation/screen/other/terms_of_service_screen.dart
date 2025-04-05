import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
              Text(l10n.termsOfService, style: MyTextStyles.title),
              const SizedBox(height: 16),
              _buildSection(l10n.termsSection1Title, l10n.termsSection1Body),
              _buildSection(l10n.termsSection2Title, l10n.termsSection2Body),
              _buildSection(l10n.termsSection3Title, l10n.termsSection3Body),
              _buildSection(l10n.termsSection4Title, l10n.termsSection4Body),
              _buildSection(l10n.termsSection5Title, l10n.termsSection5Body),
              _buildSection(l10n.termsSection6Title, l10n.termsSection6Body),
              _buildSection(l10n.termsSection7Title, l10n.termsSection7Body),
              _buildSection(l10n.termsSection8Title, l10n.termsSection8Body),
              _buildSection(l10n.termsSection9Title, l10n.termsSection9Body),
              const SizedBox(height: 16),
              Text(l10n.termsContact, style: MyTextStyles.body14),
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
