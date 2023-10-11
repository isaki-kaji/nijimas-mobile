import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/tag_controller.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';

class SearchTagDelegate extends SearchDelegate {
  final WidgetRef ref;
  List<String> selectedTags = [];
  SearchTagDelegate({required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchTagProvider(query)).when(
        data: (tags) => ListView.builder(
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) {
                final tag = tags[index];
                return ListTile(
                    title: Text(tag),
                    onTap: () => selectTag(context, tag, selectedTags));
              },
            ),
        error: (error, stacktrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }

  void selectTag(BuildContext context, String tag, List<String> selectedTags) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      if (selectedTags.length < 3) {
        selectedTags.add(tag);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(Constants.addTagDescription)));
      }
    }
  }
}
