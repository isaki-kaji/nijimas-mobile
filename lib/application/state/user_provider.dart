import 'dart:async';

import 'package:nijimas/core/model/app_user.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<AppUser> appUser(AppUserRef ref) async {
  final userRepository = ref.read(userRepositoryProvider);
  try {
    return await userRepository.getOwnUser();
  } catch (e) {
    rethrow;
  }
}
