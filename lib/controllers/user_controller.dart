import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/models/user_model/user_model.dart';
import 'package:nijimas/repositories/user_repository.dart';

class UserController extends Notifier<bool> {
  late final UserRepository _userRepository;
  late final Ref _ref;

  @override
  bool build() {
    _userRepository = _ref.watch(userRepositoryProvider);
    _ref = ref;
    return false;
  }

  Stream<UserModel> fetchUser(String uid) {
    return _userRepository.fetchUser(uid);
  }
}
