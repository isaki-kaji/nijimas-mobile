import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/usecase/favorite_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/core/util/timezone.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/presentation/screen/feed/feed_screen.dart';
import 'package:nijimas/presentation/screen/user/user_detail_screen.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  final PostQuery query;
  final bool canEdit;
  final bool isUserDetail;
  final formatter = DateFormat('yyyy-MM-dd HH:mm');

  PostCard({
    super.key,
    required this.post,
    required this.query,
    required this.canEdit,
    this.isUserDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (!isUserDetail) {
                    pushWithNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(uid: post.uid),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    SwitchCircleAvatar(
                      imageUrl: post.profileImageUrl,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(post.username, style: MyTextStyles.subtitle),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberFormat("#,###.##", "ja_JP")
                          .format(double.parse(post.expense)),
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Text(
                      "円",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (post.photoUrl.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: Sizing.heightByMQ(context, 0.3),
                viewportFraction: 0.92,
                enableInfiniteScroll: false,
              ),
              items: post.photoUrl.asMap().entries.map((entry) {
                int index = entry.key;
                String photo = entry.value;

                return GestureDetector(
                  onTap: () {
                    _showFullScreenGallery(context, index);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainCategoryChip(
                  category: MainCategory.fromName(post.mainCategory),
                ),
                ...[post.subCategory1, post.subCategory2]
                    .where((subCategory) => subCategory != null)
                    .map((subCategory) => SubCategoryChip(
                          categoryName: subCategory!,
                          fontWeight: _checkIsCurrentSubCategory(subCategory)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          tapEvent: (_) {
                            if (_checkIsCurrentSubCategory(subCategory)) {
                              return;
                            }

                            pushWithNavBar(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedScreen(
                                  query: PostQuery(
                                    type: PostQueryType.subCategory,
                                    params: {
                                      PostQueryKey.subCategory: subCategory
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
          child: Text(post.postText ?? "", style: MyTextStyles.body14),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(formatter.format(changeTZ(post.createdAt, "Asia/Tokyo")),
                  style: MyTextStyles.caption.copyWith(color: Colors.grey)),
              const SizedBox(width: 15.0),
              GestureDetector(
                child: post.isFavorite
                    ? const Icon(Icons.favorite, color: MyColors.pink)
                    : const Icon(Icons.favorite_border),
                onTap: () {
                  final favoriteUsecase = ref.read(favoriteUsecaseProvider);
                  favoriteUsecase.toggleFavorite(
                    query: query,
                    postId: post.postId,
                    isFavorite: post.isFavorite,
                    onFailure: () {},
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        const Divider(),
      ],
    );
  }

  bool _checkIsCurrentSubCategory(String subCategory) {
    return (query.type == PostQueryType.subCategory &&
        query.params[PostQueryKey.subCategory] == subCategory);
  }

  void _showFullScreenGallery(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: post.photoUrl.length,
            pageController: PageController(initialPage: initialIndex),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(post.photoUrl[index]),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
          ),
        ),
      ),
    );
  }
}
