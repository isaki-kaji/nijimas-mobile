import 'dart:typed_data';

import 'package:nijimas/core/model/user_top_subcategory.dart';

class UserFormData {
  final String username;
  final String? selfIntro;
  final Uint8List? profileImage;
  final List<UserTopSubCategory> userTopSubcategories;
  const UserFormData(
      {required this.username,
      required this.selfIntro,
      required this.profileImage,
      required this.userTopSubcategories});
}
