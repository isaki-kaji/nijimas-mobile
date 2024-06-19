import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/application/state/user_response_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';
import 'package:nijimas/presentation/widget/user/profile_header.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query =
        PostQuery(type: PostQueryType.uid, params: {PostQueryKey.uid: uid});
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(userResponseProvider(uid)).when(data: (data) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: ProfileHeader(user: data!),
              ),
            ];
          },
          body: ref.watch(postsNotifierProvider(query)).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return PostCard(post: post, query: query);
                },
              );
            },
            error: (error, _) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return const Center(child: Loader());
            },
          ),
        );
      }, error: (error, _) {
        return Center(child: Text(error.toString()));
      }, loading: () {
        return const Center(child: SizedBox());
      }),
    );
  }
}
