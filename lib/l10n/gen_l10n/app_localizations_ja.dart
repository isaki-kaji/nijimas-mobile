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

  @override
  String get food => '食事';

  @override
  String get hobbies => '趣味';

  @override
  String get fashion => 'ファッション';

  @override
  String get goods => '雑貨';

  @override
  String get essentials => '日用品';

  @override
  String get travel => '旅行';

  @override
  String get entertainment => '交際費';

  @override
  String get transport => '交通費';

  @override
  String get other => 'その他';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get googleAuthFailed => 'Google認証に失敗しました';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get appleAuthFailed => 'Apple認証に失敗しました';

  @override
  String get pleaseEnterPostInfo => '金額、メモ、画像のいずれかを入力してください';

  @override
  String get postSuccess => '投稿しました';

  @override
  String get deleteSuccess => '削除しました';

  @override
  String get postFailed => '投稿に失敗しました';

  @override
  String get updateSuccess => '修正しました';

  @override
  String get updateFailed => '修正に失敗しました';

  @override
  String get deleteFailed => '削除に失敗しました';

  @override
  String get editProfile => 'プロフィールの編集';

  @override
  String get enterName => '名前を入力してください';

  @override
  String get enterSelfIntro => '自己紹介を入力してください';

  @override
  String get updatedProfile => 'プロフィールを変更しました';

  @override
  String get failedUpdateProfile => 'プロフィールの変更に失敗しました';

  @override
  String get noPosts => '投稿はありません';

  @override
  String get noNotification => '通知はありません';
}
