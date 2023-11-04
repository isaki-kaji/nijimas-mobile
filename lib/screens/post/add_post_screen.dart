import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/providers/nijimas_notifier_provider.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/widgets/post/tag_chip.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useSelectedTags = useState<List<String>>([]);
    final useTagController = useTextEditingController();

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
        centerTitle: false,
        title: Text(nijimas, style: const TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextField(
              controller: useTagController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "タグを追加",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  if (value.length <= 20) {
                    addTag(value);
                    useTagController.clear();
                  } else {
                    showErrorSnackBar(context, "タグは20文字以内で入力してください。");
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
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
          ),
        ],
      ),
    );
  }
}
