import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/models/user_model.dart';
import 'package:nijimas/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider =
    NotifierProvider<AuthController, bool>(AuthController.new);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

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

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold((l) => showErrorSnackBar(context), (userModel) {
      _ref.read(userProvider.notifier).update(userModel);
    });
  }

  void signInAsGuest(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInAsGuest();
    state = false;
    user.fold(
      (l) => showErrorSnackBar(context),
      (userModel) => _ref.read(userProvider.notifier).update(userModel),
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    _authRepository.logOut();
  }
}
