import 'package:flutter/material.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';

enum MainCategory {
  food("food"),
  hobbies("hobbies"),
  fashion("fashion"),
  goods("goods"),
  essentials("essentials"),
  travel("travel"),
  entertainment("entertainment"),
  transport("transport"),
  other("other");

  const MainCategory(this.name);
  final String name;

  static MainCategory fromName(String name) {
    for (var category in MainCategory.values) {
      if (category.name == name) {
        return category;
      }
    }
    return MainCategory.other;
  }

  @override
  String toString() {
    return name;
  }
}

List<MainCategory> getMainCategories() {
  return MainCategory.values;
}

List<String> getMainCategoryDisplayNames(BuildContext context) {
  return MainCategory.values
      .map((category) => category.getDisplayName(context))
      .toList();
}

extension MainCategoryExtension on MainCategory {
  String getDisplayName(BuildContext context) {
    final l10n = L10n.of(context);
    switch (this) {
      case MainCategory.food:
        return l10n.food;
      case MainCategory.hobbies:
        return l10n.hobbies;
      case MainCategory.fashion:
        return l10n.fashion;
      case MainCategory.goods:
        return l10n.goods;
      case MainCategory.essentials:
        return l10n.essentials;
      case MainCategory.travel:
        return l10n.travel;
      case MainCategory.entertainment:
        return l10n.entertainment;
      case MainCategory.transport:
        return l10n.transport;
      case MainCategory.other:
        return l10n.other;
    }
  }
}
