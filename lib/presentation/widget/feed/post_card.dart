import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nijimas/application/state/own_user_detail_provider.dart';
import 'package:nijimas/application/state/posts_by_uid_provider.dart';
import 'package:nijimas/application/state/user_response_provider.dart';
import 'package:nijimas/core/provider/usecase/favorite_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/core/util/timezone.dart';
import 'package:nijimas/domain/request/toggle_favorite_request.dart';
import 'package:nijimas/domain/response/post_response.dart';
import 'package:nijimas/presentation/widget/common/switch_circle_avatar.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';

class PostCard extends ConsumerWidget {
  final PostResponse post;
  final formatter = DateFormat('yyyy-MM-dd HH:mm');
  PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userResponseProvider(post.uid)).valueOrNull;

    if (user == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SwitchCircleAvatar(
                    imageUrl: user.profileImageUrl,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(post.username, style: MyTextStyles.subtitle),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(post.expense.toString(),
                      style: MyTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text("円", style: MyTextStyles.body),
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
              MainCategoryChip(categoryName: post.mainCategory),
              post.subCategory1 != null
                  ? SubCategoryChip(categoryName: post.subCategory1!)
                  : const SizedBox(),
              post.subCategory2 != null
                  ? SubCategoryChip(categoryName: post.subCategory2!)
                  : const SizedBox()
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
          child: Text(post.postText ?? "", style: MyTextStyles.body),
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
                  final myUid =
                      ref.watch(ownUserDetailProvider).valueOrNull?.uid;
                  final postsNotifier =
                      ref.read(postsByUidNotifierProvider(myUid!).notifier);
                  postsNotifier.toggleFavorite(
                    ToggleFavoriteRequest(
                      postId: post.postId,
                      uid: myUid,
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
