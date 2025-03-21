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
