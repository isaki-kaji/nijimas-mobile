import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/models/nijimas_model.dart';

final nijimasProvider =
    NotifierProvider<NijimasNotifier, Nijimas?>(NijimasNotifier.new);

class NijimasNotifier extends Notifier<Nijimas?> {
  @override
  Nijimas? build() {
    return null;
  }

  void update(Nijimas nijimas) {
    state = nijimas;
  }
}
