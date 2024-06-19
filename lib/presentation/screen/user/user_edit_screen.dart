import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/user_response_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class UserEditScreen extends HookConsumerWidget {
  const UserEditScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useNameController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(userProfileInfoProvider(uid)).when(
        data: (data) {
          return Center(
            child: Column(
              children: [
                SwitchCircleAvatar(
                  imageUrl: data!.profileImageUrl,
                  radius: Sizing.widthByMQ(context, 0.2),
                  onTap: () {},
                ),
                TextFormField(
                  controller: useNameController,
                  decoration: const InputDecoration(
                    labelText: "名前",
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, _) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(child: Loader());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.pink,
        child: const Icon(
          Icons.done,
          color: MyColors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
