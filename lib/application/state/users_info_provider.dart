import 'dart:async';

import 'package:nijimas/core/model/user_info.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_info_provider.g.dart';

enum UserRelationType { followers, followings }

@riverpod
Future<List<UserInfo>> usersInfo(
  UsersInfoRef ref,
  ({String uid, UserRelationType type}) args,
) async {
  final userRepository = ref.read(userRepositoryProvider);

  try {
    switch (args.type) {
      case UserRelationType.followers:
        return await userRepository.getFollowers(args.uid);
      case UserRelationType.followings:
        return await userRepository.getFollowings(args.uid);
    }
  } catch (e) {
    rethrow;
  }
}
