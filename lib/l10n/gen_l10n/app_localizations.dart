import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @welcome.
  ///
  /// In ja, this message translates to:
  /// **'ようこそ！'**
  String get welcome;

  /// No description provided for @enterYourName.
  ///
  /// In ja, this message translates to:
  /// **'あなたの名前を入力してください'**
  String get enterYourName;

  /// No description provided for @nameCanBeChanged.
  ///
  /// In ja, this message translates to:
  /// **'※名前は後から変更できます。'**
  String get nameCanBeChanged;

  /// No description provided for @enterNameCaption.
  ///
  /// In ja, this message translates to:
  /// **'3〜15文字で入力してください'**
  String get enterNameCaption;

  /// No description provided for @failedToCreateUser.
  ///
  /// In ja, this message translates to:
  /// **'ユーザー登録に失敗しました'**
  String get failedToCreateUser;

  /// No description provided for @userAlreadyExists.
  ///
  /// In ja, this message translates to:
  /// **'ユーザーはすでに存在します'**
  String get userAlreadyExists;

  /// No description provided for @post.
  ///
  /// In ja, this message translates to:
  /// **'投稿'**
  String get post;

  /// No description provided for @favorite.
  ///
  /// In ja, this message translates to:
  /// **'お気に入り'**
  String get favorite;

  /// No description provided for @food.
  ///
  /// In ja, this message translates to:
  /// **'食事'**
  String get food;

  /// No description provided for @hobbies.
  ///
  /// In ja, this message translates to:
  /// **'趣味'**
  String get hobbies;

  /// No description provided for @fashion.
  ///
  /// In ja, this message translates to:
  /// **'ファッション'**
  String get fashion;

  /// No description provided for @goods.
  ///
  /// In ja, this message translates to:
  /// **'雑貨'**
  String get goods;

  /// No description provided for @essentials.
  ///
  /// In ja, this message translates to:
  /// **'日用品'**
  String get essentials;

  /// No description provided for @travel.
  ///
  /// In ja, this message translates to:
  /// **'旅行'**
  String get travel;

  /// No description provided for @entertainment.
  ///
  /// In ja, this message translates to:
  /// **'交際費'**
  String get entertainment;

  /// No description provided for @transport.
  ///
  /// In ja, this message translates to:
  /// **'交通費'**
  String get transport;

  /// No description provided for @other.
  ///
  /// In ja, this message translates to:
  /// **'その他'**
  String get other;

  /// No description provided for @continueWithGoogle.
  ///
  /// In ja, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @googleAuthFailed.
  ///
  /// In ja, this message translates to:
  /// **'Google認証に失敗しました'**
  String get googleAuthFailed;

  /// No description provided for @continueWithApple.
  ///
  /// In ja, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @appleAuthFailed.
  ///
  /// In ja, this message translates to:
  /// **'Apple認証に失敗しました'**
  String get appleAuthFailed;

  /// No description provided for @pleaseEnterPostInfo.
  ///
  /// In ja, this message translates to:
  /// **'金額、メモ、画像のいずれかを入力してください'**
  String get pleaseEnterPostInfo;

  /// No description provided for @postSuccess.
  ///
  /// In ja, this message translates to:
  /// **'投稿しました'**
  String get postSuccess;

  /// No description provided for @deleteConfirm.
  ///
  /// In ja, this message translates to:
  /// **'投稿を削除しますか?'**
  String get deleteConfirm;

  /// No description provided for @delete.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get delete;

  /// No description provided for @deleteSuccess.
  ///
  /// In ja, this message translates to:
  /// **'削除しました'**
  String get deleteSuccess;

  /// No description provided for @postFailed.
  ///
  /// In ja, this message translates to:
  /// **'投稿に失敗しました'**
  String get postFailed;

  /// No description provided for @updateSuccess.
  ///
  /// In ja, this message translates to:
  /// **'修正しました'**
  String get updateSuccess;

  /// No description provided for @updateFailed.
  ///
  /// In ja, this message translates to:
  /// **'修正に失敗しました'**
  String get updateFailed;

  /// No description provided for @deleteFailed.
  ///
  /// In ja, this message translates to:
  /// **'削除に失敗しました'**
  String get deleteFailed;

  /// No description provided for @editProfile.
  ///
  /// In ja, this message translates to:
  /// **'プロフィールの編集'**
  String get editProfile;

  /// No description provided for @enterName.
  ///
  /// In ja, this message translates to:
  /// **'名前を入力してください'**
  String get enterName;

  /// No description provided for @enterSelfIntro.
  ///
  /// In ja, this message translates to:
  /// **'自己紹介を入力してください'**
  String get enterSelfIntro;

  /// No description provided for @updatedProfile.
  ///
  /// In ja, this message translates to:
  /// **'プロフィールを変更しました'**
  String get updatedProfile;

  /// No description provided for @failedUpdateProfile.
  ///
  /// In ja, this message translates to:
  /// **'プロフィールの変更に失敗しました'**
  String get failedUpdateProfile;

  /// No description provided for @noPosts.
  ///
  /// In ja, this message translates to:
  /// **'投稿が見つかりませんでした'**
  String get noPosts;

  /// No description provided for @noNotification.
  ///
  /// In ja, this message translates to:
  /// **'通知はありません'**
  String get noNotification;

  /// No description provided for @errorOccurred.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました\n時間をおいて再度お試しください'**
  String get errorOccurred;

  /// No description provided for @aboutApp.
  ///
  /// In ja, this message translates to:
  /// **'このアプリについて'**
  String get aboutApp;

  /// No description provided for @termsOfService.
  ///
  /// In ja, this message translates to:
  /// **'利用規約'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In ja, this message translates to:
  /// **'プライバシーポリシー'**
  String get privacyPolicy;

  /// No description provided for @support.
  ///
  /// In ja, this message translates to:
  /// **'サポート'**
  String get support;

  /// No description provided for @contact.
  ///
  /// In ja, this message translates to:
  /// **'お問い合わせ'**
  String get contact;

  /// No description provided for @account.
  ///
  /// In ja, this message translates to:
  /// **'アカウント'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In ja, this message translates to:
  /// **'ログアウト'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @termsSection1Title.
  ///
  /// In ja, this message translates to:
  /// **'第1条（適用）'**
  String get termsSection1Title;

  /// No description provided for @termsSection1Body.
  ///
  /// In ja, this message translates to:
  /// **'本利用規約（以下、「本規約」といいます）は、nijimas運営チーム（以下、「当チーム」といいます）が提供するアプリ「nijimas」（以下、「本アプリ」といいます）の利用に関する条件を定めるものです。本アプリをご利用いただいた場合、本規約に同意したものとみなします。'**
  String get termsSection1Body;

  /// No description provided for @termsSection2Title.
  ///
  /// In ja, this message translates to:
  /// **'第2条（利用者）'**
  String get termsSection2Title;

  /// No description provided for @termsSection2Body.
  ///
  /// In ja, this message translates to:
  /// **'本アプリは、年齢・居住地域を問わず、どなたでもご利用いただけます。\n利用者は、自己の責任において本アプリを利用するものとします。'**
  String get termsSection2Body;

  /// No description provided for @termsSection3Title.
  ///
  /// In ja, this message translates to:
  /// **'第3条（登録・ログイン）'**
  String get termsSection3Title;

  /// No description provided for @termsSection3Body.
  ///
  /// In ja, this message translates to:
  /// **'利用者は、Googleアカウント、もしくはAppleアカウントを用いた認証により本アプリを利用できます。'**
  String get termsSection3Body;

  /// No description provided for @termsSection4Title.
  ///
  /// In ja, this message translates to:
  /// **'第4条（投稿コンテンツ）'**
  String get termsSection4Title;

  /// No description provided for @termsSection4Body.
  ///
  /// In ja, this message translates to:
  /// **'利用者は、写真、テキスト、金額などを含む投稿を行うことができます。\n投稿されたコンテンツの著作権は、当該コンテンツを投稿した利用者に帰属します。\nただし当チームは、サービスの改善・不具合対応・プロモーションの目的で、投稿内容を閲覧・分析・非公開の範囲で利用することができるものとします。'**
  String get termsSection4Body;

  /// No description provided for @termsSection5Title.
  ///
  /// In ja, this message translates to:
  /// **'第5条（禁止事項）'**
  String get termsSection5Title;

  /// No description provided for @termsSection5Body.
  ///
  /// In ja, this message translates to:
  /// **'本アプリの利用にあたり、以下の行為を禁止します：\n- 法令または公序良俗に反する行為\n- 他人の権利を侵害する行為（他人の画像の無断使用など）\n- わいせつ・暴力的・差別的な内容の投稿\n- スパムや広告行為\n- その他、当チームが不適切と判断する行為'**
  String get termsSection5Body;

  /// No description provided for @termsSection6Title.
  ///
  /// In ja, this message translates to:
  /// **'第6条（データの保存と削除）'**
  String get termsSection6Title;

  /// No description provided for @termsSection6Body.
  ///
  /// In ja, this message translates to:
  /// **'利用者の投稿データは、Cloud Storage for FirebaseおよびNeon上に保存されます。\n利用者は、自身の投稿を削除することが可能です（現在は論理削除によって対応）。\nアカウント削除機能は今後追加される予定ですが、現時点では実装されておりません。'**
  String get termsSection6Body;

  /// No description provided for @termsSection7Title.
  ///
  /// In ja, this message translates to:
  /// **'第7条（免責事項）'**
  String get termsSection7Title;

  /// No description provided for @termsSection7Body.
  ///
  /// In ja, this message translates to:
  /// **'本アプリの利用により発生したいかなる損害についても、当チームは一切の責任を負いません。\n本アプリの提供は、事前の予告なく変更・中断・終了することがあります。'**
  String get termsSection7Body;

  /// No description provided for @termsSection8Title.
  ///
  /// In ja, this message translates to:
  /// **'第8条（規約の変更）'**
  String get termsSection8Title;

  /// No description provided for @termsSection8Body.
  ///
  /// In ja, this message translates to:
  /// **'当チームは、必要と判断した場合には、利用者に通知することなく本規約を変更することがあります。変更後に本アプリを利用した場合、変更内容に同意したものとみなします。'**
  String get termsSection8Body;

  /// No description provided for @termsSection9Title.
  ///
  /// In ja, this message translates to:
  /// **'第9条（準拠法・管轄）'**
  String get termsSection9Title;

  /// No description provided for @termsSection9Body.
  ///
  /// In ja, this message translates to:
  /// **'本規約は日本法に準拠し、本アプリに関するすべての紛争については、日本の裁判所を第一審の専属的合意管轄裁判所とします。'**
  String get termsSection9Body;

  /// No description provided for @termsContact.
  ///
  /// In ja, this message translates to:
  /// **'ご質問・ご要望がある場合は、アプリ内の「お問い合わせ」からご連絡ください。'**
  String get termsContact;

  /// No description provided for @privacySection1Title.
  ///
  /// In ja, this message translates to:
  /// **'第1条（取得する情報）'**
  String get privacySection1Title;

  /// No description provided for @privacySection1Body.
  ///
  /// In ja, this message translates to:
  /// **'本アプリでは、以下の情報を取得します。\n- Firebase Authentication により取得される認証情報（Google、Apple のアカウント情報）\n- 投稿内容（画像、テキスト、金額など）\n- アプリの利用履歴・操作情報（※今後、匿名の統計データとして利用する可能性があります）'**
  String get privacySection1Body;

  /// No description provided for @privacySection2Title.
  ///
  /// In ja, this message translates to:
  /// **'第2条（情報の利用目的）'**
  String get privacySection2Title;

  /// No description provided for @privacySection2Body.
  ///
  /// In ja, this message translates to:
  /// **'取得した情報は、以下の目的に使用します。\n- 投稿の表示・管理・編集機能の提供\n- ユーザー認証およびセキュリティの維持\n- アプリの改善、不具合対応、機能開発の参考\n- 必要に応じたサポート対応'**
  String get privacySection2Body;

  /// No description provided for @privacySection3Title.
  ///
  /// In ja, this message translates to:
  /// **'第3条（情報の保管・管理）'**
  String get privacySection3Title;

  /// No description provided for @privacySection3Body.
  ///
  /// In ja, this message translates to:
  /// **'画像データは Firebase Cloud Storage に、テキストデータは Neon に保存されます。\n不正アクセス・漏洩を防ぐため、適切なセキュリティ対策を講じます。'**
  String get privacySection3Body;

  /// No description provided for @privacySection4Title.
  ///
  /// In ja, this message translates to:
  /// **'第4条（第三者提供）'**
  String get privacySection4Title;

  /// No description provided for @privacySection4Body.
  ///
  /// In ja, this message translates to:
  /// **'当チームは、ユーザーの同意がない限り、法令に基づく場合を除いて第三者に個人情報を提供しません。'**
  String get privacySection4Body;

  /// No description provided for @privacySection5Title.
  ///
  /// In ja, this message translates to:
  /// **'第5条（外部サービス）'**
  String get privacySection5Title;

  /// No description provided for @privacySection5Body.
  ///
  /// In ja, this message translates to:
  /// **'本アプリは以下の外部サービスを利用しています。各サービスのプライバシーポリシーは、それぞれの提供会社のサイトをご確認ください。\n- Firebase（Google LLC）\n- Google Sign-In / Apple Sign-In'**
  String get privacySection5Body;

  /// No description provided for @privacySection6Title.
  ///
  /// In ja, this message translates to:
  /// **'第6条（ユーザーの選択）'**
  String get privacySection6Title;

  /// No description provided for @privacySection6Body.
  ///
  /// In ja, this message translates to:
  /// **'ユーザーは自身の投稿を削除することができます（現在は論理削除）。\nアカウント削除機能は今後追加予定です。'**
  String get privacySection6Body;

  /// No description provided for @privacySection7Title.
  ///
  /// In ja, this message translates to:
  /// **'第7条（ポリシーの変更）'**
  String get privacySection7Title;

  /// No description provided for @privacySection7Body.
  ///
  /// In ja, this message translates to:
  /// **'本ポリシーは、必要に応じて内容を改訂することがあります。改訂後もアプリを継続して利用した場合は、変更に同意したものとみなされます。'**
  String get privacySection7Body;

  /// No description provided for @privacySection8Title.
  ///
  /// In ja, this message translates to:
  /// **'第8条（お問い合わせ）'**
  String get privacySection8Title;

  /// No description provided for @privacySection8Body.
  ///
  /// In ja, this message translates to:
  /// **'プライバシーポリシーに関するご質問は、アプリ内の「お問い合わせ」からご連絡ください。'**
  String get privacySection8Body;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
    case 'ja': return L10nJa();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
