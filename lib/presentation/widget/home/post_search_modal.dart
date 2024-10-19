import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';

class PostSearchDialog extends HookWidget {
  const PostSearchDialog({
    super.key,
    required this.usePostQuery,
  });

  final ValueNotifier<PostQuery> usePostQuery;

  @override
  Widget build(BuildContext context) {
    final searchedMainCategory = useState<MainCategory?>(null);
    final searchedSubCategory = useState<String?>(null);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: Sizing.heightByMQ(context, 0.3),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.9, 0.9),
              child: CustomRoundButton(
                usePostQuery: usePostQuery,
                searchedMainCategory: searchedMainCategory.value,
                searchedSubCategory: searchedSubCategory.value,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SelectMainCategoryDropdown(
                    //   searchedMainCategory: searchedMainCategory.value,
                    //   onCategorySelected: (MainCategory? category) {
                    //     searchedMainCategory.value = category;
                    //   },
                    // ),
                    //const SizedBox(height: 15),
                    SelectSubCategoryField(
                      searchedSubCategory: searchedMainCategory.value,
                      onCategorySelected: (String? category) {
                        searchedSubCategory.value = category;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectMainCategoryDropdown extends HookWidget {
  const SelectMainCategoryDropdown({
    super.key,
    required this.searchedMainCategory,
    required this.onCategorySelected,
  });

  final MainCategory? searchedMainCategory;
  final Function(MainCategory?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      width: Sizing.widthByMQ(context, 0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<MainCategory>(
            isExpanded: true,
            value: searchedMainCategory,
            hint: const Text("費目を選択"),
            onChanged: (MainCategory? value) {
              onCategorySelected(value);
            },
            items: getMainCategories()
                .map<DropdownMenuItem<MainCategory>>((MainCategory value) {
              return DropdownMenuItem<MainCategory>(
                value: value,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        value.getDisplayName(context),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class SelectSubCategoryField extends HookWidget {
  const SelectSubCategoryField({
    super.key,
    required this.searchedSubCategory,
    required this.onCategorySelected,
  });

  final MainCategory? searchedSubCategory;
  final Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final subCategoryTextController = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      width: Sizing.widthByMQ(context, 0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: subCategoryTextController,
          onChanged: (value) => onCategorySelected(value),
          decoration: const InputDecoration(
            hintText: "サブカテゴリを入力",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomRoundButton extends HookConsumerWidget {
  const CustomRoundButton({
    super.key,
    required this.usePostQuery,
    required this.searchedMainCategory,
    required this.searchedSubCategory,
  });

  final ValueNotifier<PostQuery> usePostQuery;
  final MainCategory? searchedMainCategory;
  final String? searchedSubCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if ((searchedMainCategory == null) &&
            (searchedSubCategory == null || searchedSubCategory!.isEmpty)) {
          return;
        }

        if (searchedSubCategory == null || searchedSubCategory!.isEmpty) {
          usePostQuery.value = PostQuery(
            type: PostQueryType.mainCategory,
            params: {
              PostQueryKey.mainCategory: searchedMainCategory.toString(),
            },
          );
          Navigator.of(context).pop();
          return;
        }

        if (searchedMainCategory == null) {
          usePostQuery.value = PostQuery(
            type: PostQueryType.subCategory,
            params: {
              PostQueryKey.subCategory: searchedSubCategory!,
            },
          );
          Navigator.of(context).pop();
          return;
        }

        usePostQuery.value = PostQuery(
          type: PostQueryType.mainCategoryAndSubCategory,
          params: {
            PostQueryKey.mainCategory: searchedMainCategory.toString(),
            PostQueryKey.subCategory: searchedSubCategory!,
          },
        );
        Navigator.of(context).pop();
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: MyColors.pink,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.search, color: MyColors.white),
      ),
    );
  }
}
