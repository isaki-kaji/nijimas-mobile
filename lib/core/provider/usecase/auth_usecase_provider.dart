import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/core/provider/repository/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_usecase_provider.g.dart';

@riverpod
AuthUsecase authUsecase(AuthUsecaseRef ref) {
  return AuthUsecase(
      authRepository: ref.read(authRepositoryProvider), ref: ref);
}
