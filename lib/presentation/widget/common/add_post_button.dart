import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nijimas/core/theme/color.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({super.key, required this.heroTag});

  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () => GoRouter.of(context).push('/post/add'),
      backgroundColor: MyColors.pink,
      child: const Icon(
        Icons.add,
        color: MyColors.white,
      ),
    );
  }
}
