import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(logger: ref.read(loggerProvider));
}
