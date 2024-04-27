import 'dart:typed_data';

class PostFormData {
  final String mainCategory;
  final List<String> subCategories;
  final String? postText;
  final List<Uint8List?> images;
  final String? expense;
  final String publicTypeNo;
  const PostFormData(
      {required this.mainCategory,
      required this.subCategories,
      required this.postText,
      required this.images,
      required this.expense,
      required this.publicTypeNo});
}
