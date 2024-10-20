import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/core/util/timezone.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/request/toggle_favorite_request.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  final bool canTap;
  final formatter = DateFormat('yyyy-MM-dd HH:mm');
  PostCard({super.key, required this.post, required this.canTap});

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
                  if (canTap) {
                    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;
                    final query = (post.uid == myUid)
                        ? PostQuery(type: PostQueryType.own, params: {})
                        : PostQuery(
                            type: PostQueryType.uid,
                            params: {PostQueryKey.uid: post.uid});
                    ref.read(postQueryNotifierProvider.notifier).set(query);
                    GoRouter.of(context).push("/profile/${post.uid}");
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(post.expense,
                      style: MyTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text("円", style: MyTextStyles.body14),
                ],
              ),
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
              items: post.photoUrl.map((photo) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: photo,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
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
              const SizedBox(width: 8.0),
              GestureDetector(
                child: post.isFavorite
                    ? const Icon(Icons.favorite, color: MyColors.pink)
                    : const Icon(Icons.favorite_border),
                onTap: () {
                  final query = ref.watch(postQueryNotifierProvider);
                  final postsNotifier =
                      ref.watch(postsNotifierProvider(query).notifier);
                  postsNotifier.toggleFavorite(
                    ToggleFavoriteRequest(
                      postId: post.postId,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        const Divider(),
      ],
    );
  }
}
