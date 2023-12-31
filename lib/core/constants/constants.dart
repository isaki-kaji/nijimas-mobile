import 'package:nijimas/screens/feed/feed_screen.dart';
import 'package:nijimas/screens/nijimas/nijimas_map_screen.dart';

class Constants {
  static const nijimasLogoPath = "assets/images/nijimas.png";
  static const nijimasTitlePath = "assets/images/title.png";
  static const googleLogoPath = "assets/images/googleLogo.png";
  static const defaultAvatarPath = "assets/images/avatar.png";
  static const defaultBannerPath = "assets/images/banner.png";

  static const tabPages = [FeedScreen(), NijimasMapScreen()];

  static const errorMessage = "何らかのエラーが発生しました。時間をおいて再度お試しください…";

  static const doNijimasDescription =
      "新たなニジマスが登録されました。次はこの区画内で起こった出来事を投稿してみましょう。";

  static const addTagDescription = "登録できるタグは3つまでです。";

  static const cameraButtonDescription =
      "まずは画面中央のNijimasボタンをタップしてNijimasを登録しましょう。";

  static const storePhotoErrorMessage = "写真の保存に失敗しました。時間をおいて再度お試しください。";

  static const storePhotoSuccessMessage = "写真の保存に成功しました。";
}
