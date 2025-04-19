import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/usecase/favorite_usecase_provider.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/core/util/timezone.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  final PostQuery query;
  final bool canTap;
  final bool canEdit;
  final formatter = DateFormat('yyyy-MM-dd HH:mm');
  PostCard(
      {super.key,
      required this.post,
      required this.query,
      required this.canTap,
      required this.canEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
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
                  if (canTap) {
                    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;
                    if (myUid != post.uid) {
                      GoRouter.of(context).push("/profile/${post.uid}");
                    }
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
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              MainCategoryChip(
                  category: MainCategory.fromName(post.mainCategory)),
              post.subCategory1 != null
                  ? SubCategoryChip(
                      categoryName: post.subCategory1!,
                      tapEvent: (_) {
                        if (canTap) {
                          ref.read(postQueryNotifierProvider.notifier).set(
                                  PostQuery(
                                      type: PostQueryType.subCategory,
                                      params: {
                                    PostQueryKey.subCategory: post.subCategory1!
                                  }));
                        }
                      },
                    )
                  : const SizedBox(),
              post.subCategory2 != null
                  ? SubCategoryChip(
                      categoryName: post.subCategory2!,
                      tapEvent: (_) {
                        if (canTap) {
                          ref.read(postQueryNotifierProvider.notifier).set(
                                  PostQuery(
                                      type: PostQueryType.subCategory,
                                      params: {
                                    PostQueryKey.subCategory: post.subCategory2!
                                  }));
                        }
                      })
                  : const SizedBox()
            ]),
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
                  final usecase = ref.read(favoriteUsecaseProvider(query));
                  usecase.toggleFavorite(
                    postId: post.postId,
                    isFavorite: post.isFavorite,
                    onFailure: () {},
                  );
                },
              ),
              if (canEdit) const SizedBox(width: 15.0),
              if (canEdit)
                GestureDetector(
                  child: const Icon(Icons.edit, color: MyColors.grey),
                  onTap: () {
                    GoRouter.of(context).push('/post/edit', extra: post);
                  },
                ),
              if (canEdit) const SizedBox(width: 15.0),
              if (canEdit)
                GestureDetector(
                  child: const Icon(Icons.delete, color: MyColors.grey),
                  onTap: () {
                    final postUsecase = ref.read(postUsecaseProvider);
                    postUsecase.deletePost(
                      postId: post.postId,
                      photoUrls: post.photoUrl,
                      onSuccess: () {
                        ref.invalidate(postsNotifierProvider);
                        ref.invalidate(monthlySummaryPresentationProvider(
                            DateTime.now().year.toString(),
                            DateTime.now().month.toString()));
                        showSuccessSnackBar(context, l10n.deleteSuccess);
                      },
                      onFailure: () {
                        showErrorSnackBar(context, l10n.deleteFailed);
                      },
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
