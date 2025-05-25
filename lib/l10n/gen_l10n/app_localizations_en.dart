import 'app_localizations.dart';

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome!';

  @override
  String get enterYourName => 'Please enter your name';

  @override
  String get nameCanBeChanged => '*You can change your name later.';

  @override
  String get enterNameCaption => 'Please enter 2 to 10 characters';

  @override
  String get failedToCreateUser => 'Failed to register user';

  @override
  String get userAlreadyExists => 'User already exists';

  @override
  String get post => 'posts';

  @override
  String get favorite => 'favorites';

  @override
  String get food => 'Food';

  @override
  String get hobbies => 'Hobbies';

  @override
  String get fashion => 'Fashion';

  @override
  String get goods => 'Miscellaneous goods';

  @override
  String get essentials => 'Daily necessities';

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
  String get pleaseEnterPostInfo => 'Please enter an amount, memo, or image';

  @override
  String get postSuccess => 'Posted successfully';

  @override
  String get deleteConfirm => 'Are you sure you want to delete this?';

  @override
  String get delete => 'delete';

  @override
  String get deleteSuccess => 'Deleted successfully';

  @override
  String get postFailed => 'Failed to post';

  @override
  String get updateSuccess => 'Updated successfully';

  @override
  String get updateFailed => 'Failed to update';

  @override
  String get deleteFailed => 'Failed to delete';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get enterName => 'Please enter your name';

  @override
  String get enterSelfIntro => 'Please enter your self-introduction';

  @override
  String get updatedProfile => 'Profile updated';

  @override
  String get failedUpdateProfile => 'Failed to update profile';

  @override
  String get noPosts => 'No posts found';

  @override
  String get noNotification => 'No notifications';

  @override
  String get errorOccurred => 'An error occurred.\nPlease try again later';

  @override
  String get aboutApp => 'About This App';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get support => 'Support';

  @override
  String get contact => 'Contact';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';

  @override
  String get cancel => 'cancel';

  @override
  String get copied => 'copied';

  @override
  String get termsSection1Title => 'Article 1 (Application)';

  @override
  String get termsSection1Body => 'These Terms of Service (hereinafter referred to as the \"Terms\") set forth the conditions for using the app \"nijimas\" (hereinafter referred to as the \"App\") provided by the nijimas operations team (hereinafter referred to as the \"Team\"). By using this App, you agree to these Terms.';

  @override
  String get termsSection2Title => 'Article 2 (Users)';

  @override
  String get termsSection2Body => 'This app is available to everyone, regardless of age or region.\nUsers shall use the app at their own responsibility.';

  @override
  String get termsSection3Title => 'Article 3 (Registration and Login)';

  @override
  String get termsSection3Body => 'Users can access the app via authentication using a Google or Apple account.';

  @override
  String get termsSection4Title => 'Article 4 (Posted Content)';

  @override
  String get termsSection4Body => 'Users may post content including photos, text, and amounts.\nCopyright of posted content belongs to the user who posted it.\nHowever, the Team may access and analyze posted content for the purposes of improving the service, fixing bugs, and internal promotion.';

  @override
  String get termsSection5Title => 'Article 5 (Prohibited Acts)';

  @override
  String get termsSection5Body => 'The following acts are prohibited when using this app:\n- Acts that violate laws or public order and morals\n- Infringement of the rights of others (e.g. unauthorized use of images)\n- Posting obscene, violent, or discriminatory content\n- Spam or advertising activities\n- Other acts deemed inappropriate by the Team';

  @override
  String get termsSection6Title => 'Article 6 (Data Storage and Deletion)';

  @override
  String get termsSection6Body => 'User post data is stored in Cloud Storage for Firebase and Neon. Users can delete their own posts (currently handled via logical deletion). An account deletion feature is planned to be added in the future, but it is not currently implemented. Upon individual request via inquiry, we will delete user data as requested.';

  @override
  String get termsSection7Title => 'Article 7 (Disclaimer)';

  @override
  String get termsSection7Body => 'The Team is not responsible for any damage caused by the use of this app.\nThe app may be changed, suspended, or terminated without prior notice.';

  @override
  String get termsSection8Title => 'Article 8 (Changes to Terms)';

  @override
  String get termsSection8Body => 'The Team may change these Terms without notifying users if deemed necessary. Continued use of the app after changes constitutes agreement to the new Terms.';

  @override
  String get termsSection9Title => 'Article 9 (Governing Law and Jurisdiction)';

  @override
  String get termsSection9Body => 'These Terms shall be governed by Japanese law. Any disputes related to the app shall be subject to the exclusive jurisdiction of the Japanese courts in the first instance.';

  @override
  String get termsContact => 'If you have any questions or requests, please contact us through the \"Contact\" section in the app.';

  @override
  String get privacySection1Title => 'Article 1 (Information Collected)';

  @override
  String get privacySection1Body => 'This app collects the following information:\n- Authentication data via Firebase Authentication (Google/Apple account info)\n- Post content (images, text, amounts, etc.)\n- Usage history and operation data (may be used for anonymous statistics in the future)';

  @override
  String get privacySection2Title => 'Article 2 (Purpose of Use)';

  @override
  String get privacySection2Body => 'Collected information is used for the following purposes:\n- Displaying, managing, and editing posts\n- User authentication and security\n- App improvement, bug fixing, and feature development\n- Providing necessary support';

  @override
  String get privacySection3Title => 'Article 3 (Data Storage and Management)';

  @override
  String get privacySection3Body => 'Images are stored in Firebase Cloud Storage, and text data is stored in Neon.\nProper security measures are in place to prevent unauthorized access or leakage.';

  @override
  String get privacySection4Title => 'Article 4 (Third-Party Disclosure)';

  @override
  String get privacySection4Body => 'The Team will not provide personal information to third parties without user consent unless required by law.';

  @override
  String get privacySection5Title => 'Article 5 (External Services)';

  @override
  String get privacySection5Body => 'This app uses the following external services. Please refer to the privacy policies of each provider:\n- Firebase (Google LLC)\n- Google Sign-In / Apple Sign-In';

  @override
  String get privacySection6Title => 'Article 6 (User Choices)';

  @override
  String get privacySection6Body => 'Users can delete their own posts (currently handled via logical deletion). An account deletion feature is planned to be added in the future. Upon individual request via inquiry, we will delete user data as requested.';

  @override
  String get privacySection7Title => 'Article 7 (Changes to Policy)';

  @override
  String get privacySection7Body => 'This policy may be revised as needed. Continued use of the app after changes constitutes agreement to the new policy.';

  @override
  String get privacySection8Title => 'Article 8 (Contact)';

  @override
  String get privacySection8Body => 'If you have questions about this privacy policy, please contact us through the \"Contact\" section in the app.';
}
