import 'package:nijimas/screens/nijimas/nijimas_map_screen.dart';
import 'package:nijimas/screens/nijimas/nijimas_post_screen.dart';

class Constants {
  static const nijimasLogoPath = "assets/images/nijimas.png";
  static const nijimasTitlePath = "assets/images/title.png";
  static const googleLogoPath = "assets/images/googleLogo.png";
  static const defaultAvatarPath = "assets/images/avatar.png";
  static const defaultBannerPath = "assets/images/banner.png";

  static const tabPages = [NijimasPostScreen(), NijimasMapScreen()];

  static const doNijimasDescription =
      "新たなニジマスログが登録されました。次にこのアプリのカメラから撮った写真をあなたのニジマスログに追加してみましょう。";
}
