import 'package:nijimas/core/model/user_detail.dart';
import 'package:nijimas/core/provider/repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_detail_provider.g.dart';

@riverpod
class UserDetailNotifier extends _$UserDetailNotifier {
  @override
  Future<UserDetail> build(String uid) async {
    try {
      final userRepository = ref.read(userRepositoryProvider);
      return await userRepository.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }

  void setFollowingStatus(String followingStatus) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedUserDetail = currentState.copyWith(
      followingStatus: followingStatus,
    );
    state = AsyncValue.data(updatedUserDetail);
  }

  // void setUserTopSubCategories(List<SubCategory> topSubCategories) {
  //   final currentState = state.valueOrNull;
  //   if (currentState == null) return;

  //   final updatedTopSubcategories =
  //       topSubCategories.asMap().entries.map((entry) {
  //     final index = entry.key;
  //     final subCategory = entry.value;

  //     return UserTopSubCategory(
  //       categoryName: subCategory.categoryName,
  //       categoryId: subCategory.categoryId,
  //       categoryNo: (index + 1).toString(),
  //     );
  //   }).toList();

  //   final updatedUserDetail = currentState.copyWith(
  //     userFavoriteSubcategories: updatedTopSubcategories,
  //   );

  //   state = AsyncValue.data(updatedUserDetail);
  // }
}
