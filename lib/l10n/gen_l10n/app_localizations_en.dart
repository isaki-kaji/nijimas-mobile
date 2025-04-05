import 'app_localizations.dart';

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'welcome!!';

  @override
  String get enterYourName => 'Please enter your name';

  @override
  String get nameCanBeChanged => '*Names can be changed later';

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
  String get entertainment => 'Entertainment';

  @override
  String get transport => 'Transportation';

  @override
  String get other => 'Others';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get googleAuthFailed => 'Google authentication failed';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get appleAuthFailed => 'Apple authentication failed';

  @override
  String get pleaseEnterPostInfo => 'Please enter an expense, a memo, or at least one image';

  @override
  String get postSuccess => 'Posted!!';

  @override
  String get deleteSuccess => 'Deleted!!';

  @override
  String get postFailed => 'Post Failed';

  @override
  String get updateSuccess => 'Successfully Updated!';

  @override
  String get updateFailed => 'Failed to Update';

  @override
  String get deleteFailed => 'Failed to Delete';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get enterName => 'Please enter your name';

  @override
  String get enterSelfIntro => 'Pleas enter your self-introduction';

  @override
  String get updatedProfile => 'Profile updated!!';

  @override
  String get failedUpdateProfile => 'Profile update failed';

  @override
  String get noPosts => 'No posts found';

  @override
  String get noNotification => 'No Notification';

  @override
  String get errorOccurred => 'An error occurred.\nPlease try again later';

  @override
  String get aboutApp => 'About this App';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get support => 'Support';

  @override
  String get help => 'Help';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';
}
