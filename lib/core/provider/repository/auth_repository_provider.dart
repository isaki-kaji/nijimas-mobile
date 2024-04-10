import 'package:nijimas/core/provider/other/firebase_auth_provider.dart';
import 'package:nijimas/core/provider/other/google_signin_provider.dart';
import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
      firebaseAuth: ref.read(firebaseAuthProvider),
      googleSignIn: ref.read(googleSigninProvider),
      logger: ref.read(loggerProvider));
}
