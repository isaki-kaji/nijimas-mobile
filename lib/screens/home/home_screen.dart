import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/widgets/home/profile_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // print("build");
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(actions: [
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user!.profileImagePath),
              ),
              onPressed: () => showEndDrawer(context),
            ),
          );
        })
      ]),
      endDrawer: const ProfileDrawer(),
      body: const Center(
        child: Text("Hey"),
      ),
    );
  }
}
