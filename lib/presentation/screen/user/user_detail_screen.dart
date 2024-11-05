import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/post_query_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/feed/post_card.dart';
import 'package:nijimas/presentation/widget/user/profile_header.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;
    final query = ref.watch(postQueryNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (myUid == uid)
              PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(l10n.editProfile),
                    onTap: () =>
                        GoRouter.of(context).push("/profile/$myUid/edit"),
                  ),
                ];
              })
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: ProfileHeader(uid: uid),
              ),
            ];
          },
          body: ref.watch(postsNotifierProvider(query)).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return PostCard(post: post, canTap: false);
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
        ));
  }
}
