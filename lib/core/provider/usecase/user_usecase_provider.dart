import 'package:nijimas/application/usecase/user_usecase.dart';
import 'package:nijimas/core/provider/repository/auth_repository_provider.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:nijimas/core/provider/repository/user_status_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_usecase_provider.g.dart';

@riverpod
UserUsecase userUsecase(UserUsecaseRef ref) {
  return UserUsecase(
      userRepository: ref.read(userRepositoryProvider),
      userStatusRepository: ref.read(userStatusRepositoryProvider),
      authRepository: ref.read(authRepositoryProvider),
      ref: ref);
}
