class PostFormData {
  final String mainCategory;
  final List<String> subCategories;
  final String? postText;
  final String? photoUrl;
  final int? expense;
  final String publicTypeNo;
  const PostFormData(
      {required this.mainCategory,
      required this.subCategories,
      this.postText,
      this.photoUrl,
      this.expense,
      required this.publicTypeNo});
}
