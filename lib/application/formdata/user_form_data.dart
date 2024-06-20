import 'dart:typed_data';

class UserFormData {
  final String username;
  final String? selfIntro;
  final Uint8List? profileImage;
  const UserFormData(
      {required this.username,
      required this.selfIntro,
      required this.profileImage});
}
