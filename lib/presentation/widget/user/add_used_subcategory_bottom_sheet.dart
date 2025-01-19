import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/application/state/user_used_subcategories_provider.dart';
import 'package:nijimas/core/model/sub_category.dart';
import 'package:nijimas/core/model/user_top_subcategory.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';

class AddUsedSubcategoryBottomSheet extends HookConsumerWidget {
  final List<UserTopSubCategory> topSubCategories;
  const AddUsedSubcategoryBottomSheet(
      {super.key, required this.topSubCategories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<SubCategory> subCategories = topSubCategories
        .map((topSubCategory) => topSubCategory.toSubCategory())
        .toList();
    final useUserTopSubCategories = useState<List<SubCategory>>(subCategories);

    void toggleTopSubCategory(
        bool isCurrentTopSubCategory, int index, SubCategory category) {
      if (isCurrentTopSubCategory) {
        useUserTopSubCategories.value.removeAt(index);
      } else {
        if (useUserTopSubCategories.value.length >= 4) {
          return;
        }
        useUserTopSubCategories.value.add(category);
      }
      useUserTopSubCategories.value =
          List<SubCategory>.from(useUserTopSubCategories.value);

      final uid = ref.read(authStateProvider).valueOrNull!.uid;
      ref
          .read(userDetailNotifierProvider(uid).notifier)
          .setUserTopSubCategories(useUserTopSubCategories.value);
    }

    return ref.watch(userUsedSubCategoriesProvider).when(
          data: (categories) {
            return Container(
              height: Sizing.heightByMQ(context, 0.7),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 2,
                  runSpacing: 5,
                  children: categories.map((category) {
                    final isCurrentTopSubCategoryIndex =
                        useUserTopSubCategories.value.indexWhere(
                      (topSubCategory) =>
                          topSubCategory.categoryName == category.categoryName,
                    );

                    final isCurrentTopSubCategory =
                        isCurrentTopSubCategoryIndex != -1;

                    return GestureDetector(
                        onTap: () => toggleTopSubCategory(
                            isCurrentTopSubCategory,
                            isCurrentTopSubCategoryIndex,
                            category),
                        child: IntrinsicWidth(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Stack(
                              children: [
                                Card(
                                  color: isCurrentTopSubCategory
                                      ? MyColors.pink
                                      : null,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30),
                                      right: Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            category.categoryName,
                                            style: TextStyle(
                                                color: isCurrentTopSubCategory
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (isCurrentTopSubCategory)
                                  Positioned(
                                    bottom: 2,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: MyColors.lightGreen,
                                      child: Text(
                                        (isCurrentTopSubCategoryIndex + 1)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, _) => Center(child: Text(error.toString())),
        );
  }
}
