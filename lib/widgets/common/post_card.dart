import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/user_controller.dart';
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
                      Text(data.name),
                    ],
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
