import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/tag_controller.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/post/tag_list_tile.dart';
import 'package:rxdart/rxdart.dart';

class SearchTagDelegate extends SearchDelegate {
  final WidgetRef ref;
  final void Function(String) addTag;
  final _querySubject = BehaviorSubject<String>();

  SearchTagDelegate({required this.ref, required this.addTag});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          _querySubject.add(query);
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _querySubject.add(query);

    return StreamBuilder<String>(
      stream: _querySubject.debounceTime(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final delayedQuery = snapshot.data ?? '';
        return ref.watch(searchTagProvider(delayedQuery)).when(
            data: (tags) => ListView.builder(
                  itemCount: tags.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return null;
                    }

                    final tag = tags[index - 1];
                    return TagListTile(
                      tagName: tag.tagName,
                      addTag: () {
                        addTag(tag.tagName);
                        close(context, tag.tagName);
                      },
                    );
                  },
                ),
            error: (error, stacktrace) => ErrorText(error: error.toString()),
            loading: () => TagListTile(
                tagName: query,
                addTag: () {
                  if (query.isNotEmpty && query.length < 30) {
                    addTag(query);
                    close(context, query);
                  } else {
                    showErrorSnackBar(context, "タグは30文字以内で入力してください。");
                  }
                }));
      },
    );
  }

  @override
  void close(BuildContext context, result) {
    _querySubject.close();
    super.close(context, result);
  }
}
