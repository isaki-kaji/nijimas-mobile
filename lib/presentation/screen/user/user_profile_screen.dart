import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("user profile")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).go("/");
          },
          child: const Icon(Icons.add),
        ));
  }
}
