import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//text,isPublic,tags,imageUrlsが入力可能

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: [TextField()]),
        ));
  }
}
