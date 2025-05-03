import 'dart:async';

import 'package:nijimas/core/model/user_info.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_info_provider.g.dart';

enum UserRelationType { followers, followings, favorites }

@riverpod
Future<List<UserInfo>> usersInfo(
  UsersInfoRef ref,
  ({
    UserRelationType type,
    String? uid,
    String? postId,
  }) args,
) async {
  final userRepository = ref.read(userRepositoryProvider);

  try {
    switch (args.type) {
      case UserRelationType.followers:
        return await userRepository.getFollowers(args.uid!);
      case UserRelationType.followings:
        return await userRepository.getFollowings(args.uid!);
      case UserRelationType.favorites:
        return await userRepository.getFavorites(args.postId!);
      default:
        throw Exception("Invalid user relation type");
    }
  } catch (e) {
    rethrow;
  }
}
