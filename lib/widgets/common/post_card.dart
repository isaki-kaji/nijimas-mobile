import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/post_controller.dart';
import 'package:nijimas/controllers/user_controller.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/theme/text_styles.dart';
import 'package:nijimas/models/post_model.dart';
import 'package:nijimas/widgets/common/error_text.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  void favoritePost(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).favoritePost(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return ref.watch(getUserByIdProvider(post.uid)).when(
          data: (data) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(data.profileImagePath),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(data.name, style: TextStyles.subTitle()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: post.tags.map((tag) {
                        return Text("#$tag", style: TextStyles.tag());
                      }).toList(),
                    ),
                  ),
                ),
                if (post.photos!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        viewportFraction: 0.92,
                        enableInfiniteScroll: false,
                      ),
                      items: post.photos!.map((photo) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                              child: Image.network(
                                photo,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                if (post.text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(post.text!),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.locationDot,
                                size: 20.0),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8.0),
                          (post.favoriteUids.contains(user!.uid))
                              ? IconButton(
                                  onPressed: () => favoritePost(ref),
                                  icon: const Icon(Icons.favorite),
                                  color: MyColors.pinkColor,
                                )
                              : IconButton(
                                  onPressed: () => favoritePost(ref),
                                  icon: const Icon(Icons.favorite_border),
                                ),
                          Text(post.favoriteUids.length.toString()),
                        ],
                      ),
                      (post.uid == user!.uid)
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: MyColors.redColor,
                              ))
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                const SizedBox(height: 6.0),
                const Divider(),
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const SizedBox.shrink(),
        );
  }
}
