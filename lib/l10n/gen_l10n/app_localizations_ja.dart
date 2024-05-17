import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get welcome => 'ようこそ！';

  @override
  String get enterYourName => 'あなたの名前を入力してください';

  @override
  String get nameCanBeChanged => '※名前は後から変更できます。';

  @override
  String get enterNameCaption => '3〜15文字で入力してください';

  @override
  String get failedToCreateUser => 'ユーザー登録に失敗しました';

  @override
  String get userAlreadyExists => 'ユーザーはすでに存在します';
}
