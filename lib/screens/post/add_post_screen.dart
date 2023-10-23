import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/delegates/search_tag_delegate.dart';
import 'package:nijimas/core/providers/nijimas_notifier_provider.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/widgets/post/tag_chip.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useSelectedTags = useState<List<String>>([]);

    final nijimas = ref.watch(nijimasProvider)!.section;

    void addTag(String tagName) {
      if (useSelectedTags.value.length < 3) {
        useSelectedTags.value = [...useSelectedTags.value, tagName];
      } else {
        showErrorSnackBar(context, "登録できるタグは3つまでです。");
      }
    }

    void removeTag(String tagName) {
      useSelectedTags.value =
          useSelectedTags.value.where((tag) => tag != tagName).toList();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text(
                "タグを追加",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onTap: () {
            showSearch(
                context: context,
                delegate: SearchTagDelegate(ref: ref, addTag: addTag));
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: useSelectedTags.value.map((tag) {
                return TagChip(
                  tagName: tag,
                  removeTag: (tagToRemove) => removeTag(tagToRemove),
                );
              }).toList(),
            ),
          ),
          Text(nijimas)
        ],
      ),
    );
  }
}
