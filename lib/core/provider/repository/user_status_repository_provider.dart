import 'package:nijimas/core/provider/other/firestore_provider.dart';
import 'package:nijimas/core/provider/other/logger_provider.dart';
import 'package:nijimas/repository/user_status_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_status_repository_provider.g.dart';

@riverpod
UserStatusRepository userStatusRepository(UserStatusRepositoryRef ref) {
  return UserStatusRepository(
      firestore: ref.read(firestoreProvider), logger: ref.read(loggerProvider));
}
