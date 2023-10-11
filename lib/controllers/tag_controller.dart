import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Stream<List<String>> searchTag(String query) {
    return _tagRepository.searchTag(query);
  }
}
