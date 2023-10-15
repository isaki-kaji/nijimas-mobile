import 'package:flutter/material.dart';

class TagListTile extends StatelessWidget {
  final String tagName;
  final void Function() addTag;
  const TagListTile({super.key, required this.tagName, required this.addTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: ListTile(
        title: Text(tagName),
        onTap: () {
          addTag();
        },
      ),
    );
  }
}
