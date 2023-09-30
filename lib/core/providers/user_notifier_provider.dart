import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/models/user_model/user_model.dart';

final userProvider =
    NotifierProvider<UserModelNotifier, UserModel?>(UserModelNotifier.new);

class UserModelNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return null;
  }

  void update(UserModel userModel) {
    state = userModel;
  }
}
