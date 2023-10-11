import 'package:nijimas/screens/nijimas/nijimas_map_screen.dart';
import 'package:nijimas/screens/nijimas/nijimas_post_screen.dart';

class Constants {
  static const nijimasLogoPath = "assets/images/nijimas.png";
  static const nijimasTitlePath = "assets/images/title.png";
  static const googleLogoPath = "assets/images/googleLogo.png";
  static const defaultAvatarPath = "assets/images/avatar.png";
  static const defaultBannerPath = "assets/images/banner.png";

  static const tabPages = [NijimasPostScreen(), NijimasMapScreen()];

  static const errorMessage = "何らかのエラーが発生しました。時間をおいて再度お試しください…";

  static const doNijimasDescription =
      "新たなニジマスログが登録されました。次はこの区画内で起こった出来事を投稿してみましょう。";

  static const addTagDescription = "登録できるタグは3つまでです。";
}
