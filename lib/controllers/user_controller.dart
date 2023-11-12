import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/models/user_model/user_model.dart';
import 'package:nijimas/repositories/user_repository.dart';

final userControllerProvider =
    NotifierProvider<UserController, bool>(UserController.new);

final getUserByIdProvider = StreamProvider.family((ref, String uid) {
  return ref.read(userControllerProvider.notifier).getUserById(uid);
});

class UserController extends Notifier<bool> {
  late final UserRepository _userRepository;
  late final Ref _ref;

  @override
  bool build() {
    _userRepository = ref.watch(userRepositoryProvider);
    _ref = ref;
    return false;
  }

  Stream<UserModel> getUserById(String uid) {
    return _userRepository.getUserById(uid);
  }
}
