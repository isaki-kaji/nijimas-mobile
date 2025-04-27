import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/home/menu_drawer.dart';
import 'package:nijimas/presentation/widget/home/post_search_dialog.dart';

class GuestScreen extends ConsumerWidget {
  const GuestScreen({super.key});

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return const PostSearchDialog();
            //   },
            // );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return TrailingIconButton(
                  onPressed: () async {
                    showEndDrawer(context);
                    final user = ref.read(authStateProvider).value!;
                    final token = await user.getIdToken();
                    if (token == null) {
                      return;
                    }
                  },
                  icon: Icons.account_circle);
            },
          )
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Nijimas!"),
          ],
        ),
      ),
      endDrawer: const MenuDrawer(
        isGuestUser: true,
      ),
    );
  }
}
