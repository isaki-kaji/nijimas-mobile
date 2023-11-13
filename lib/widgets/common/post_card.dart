import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/user_controller.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/theme/text_styles.dart';
import 'package:nijimas/models/post_model.dart';
import 'package:nijimas/widgets/common/error_text.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserByIdProvider(post.uid)).when(
          data: (data) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 4.0),
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
                const Divider(),
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const SizedBox.shrink(),
        );
  }
}
