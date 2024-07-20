import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:nijimas/core/model/user_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_info_provider.g.dart';

@riverpod
Future<UserProfile?> userProfileInfo(UserProfileInfoRef ref, String uid) async {
  return await ref.watch(userRepositoryProvider).getUser(uid);
}
