import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/feed/posts_line.dart';
import 'package:nijimas/presentation/widget/user/profile_header.dart';

class UserDetailScreen extends HookConsumerWidget {
  const UserDetailScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final myUid = ref.watch(authStateProvider).valueOrNull!.uid;

    final query = (uid == myUid)
        ? PostQuery(type: PostQueryType.own, params: {})
        : PostQuery(type: PostQueryType.uid, params: {PostQueryKey.uid: uid});

    final useQuery = useState(query);

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
          body: PostsLine(
            query: useQuery.value,
            canTap: false,
          ),
        ));
  }
}
