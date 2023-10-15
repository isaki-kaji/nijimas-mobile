import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/models/tag_model/tag_model.dart';
import 'package:nijimas/repositories/tag_repository.dart';

final tagControllerProvider =
    AsyncNotifierProvider<TagController, void>(TagController.new);

final searchTagProvider = StreamProvider.family((ref, String query) {
  return ref.watch(tagControllerProvider.notifier).searchTag(query);
});

class TagController extends AsyncNotifier<void> {
  late final TagRepository _tagRepository;

  @override
  String build() {
    _tagRepository = ref.watch(tagRepositoryProvider);
    return "";
  }

  void addTag(String name, BuildContext context) async {
    Tag tag = Tag(tagName: name, usageCount: 0, createdAt: DateTime.now());

    final res = await _tagRepository.addTag(tag);

    res.fold(
        (l) => showErrorSnackBar(context, Constants.errorMessage), (r) => null);
  }

  Stream<List<Tag>> searchTag(String query) {
    return _tagRepository.searchTag(query);
  }
}
