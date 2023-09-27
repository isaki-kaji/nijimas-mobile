import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/models/user_model.dart';

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
