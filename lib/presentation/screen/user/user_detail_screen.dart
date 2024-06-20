import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/application/state/user_profile_info_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';
import 'package:nijimas/presentation/widget/user/profile_header.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;
    final query =
        PostQuery(type: PostQueryType.uid, params: {PostQueryKey.uid: uid});
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (myUid == uid)
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("ユーザ情報の編集"),
                  onTap: () => GoRouter.of(context).push("/profile/$uid/edit"),
                ),
              ];
            })
        ],
      ),
      body: ref.watch(userProfileInfoProvider(uid)).when(data: (data) {
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
