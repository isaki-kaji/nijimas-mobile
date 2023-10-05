import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/providers/storage_repository_provider.dart';
import 'package:nijimas/repositories/nijimas_repository.dart';

final nijimasControllerProvider =
    NotifierProvider<NijimasController, bool>(NijimasController.new);

class NijimasController extends Notifier<bool> {
  late final NijimasRepository _nijimasRepository;
  late final StorageRepository _storageRepository;
  late final Ref _ref;

  @override
  bool build() {
    _nijimasRepository = ref.watch(nijimasRepositoryProvider);
    _storageRepository = ref.watch(storageRepositoryProvider);
    _ref = ref;
    return false;
  }
}
