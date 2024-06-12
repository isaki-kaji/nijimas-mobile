import 'app_localizations.dart';

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'welcome!!';

  @override
  String get enterYourName => 'Please enter your name';

  @override
  String get nameCanBeChanged => '*Names can be changed later.';

  @override
  String get enterNameCaption => 'Please enter 3 to 15 characters';

  @override
  String get failedToCreateUser => 'User registration failed';

  @override
  String get userAlreadyExists => 'User already exists';

  @override
  String get food => 'Food';

  @override
  String get hobbies => 'Hobbies';

  @override
  String get fashion => 'Fashion';

  @override
  String get goods => 'Miscellaneous Goods';

  @override
  String get essentials => 'Daily Necessities';

  @override
  String get travel => 'Travel';

  @override
  String get entertainment => 'Entertainment Expenses';

  @override
  String get transport => 'Transportation Expenses';

  @override
  String get other => 'Others';
}
