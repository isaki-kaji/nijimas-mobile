import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/repositories/auth_repository.dart';

final communityControllerProvider =
    NotifierProvider<AuthController, bool>(AuthController.new);

class AuthController extends Notifier<bool> {
  late final AuthRepository _authRepository;
  late final Ref _ref;

  @override
  bool build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _ref = ref;
    return false;
  }

  Stream<User?> get authStateChange => _authRepository.authStateChange;
}
