import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';

class PostSearchModal extends HookWidget {
  const PostSearchModal({
    super.key,
    required this.usePostQuery,
  });

  final ValueNotifier<PostQuery> usePostQuery;

  @override
  Widget build(BuildContext context) {
    final searchedMainCategory = useState<MainCategory?>(null);

    return Container(
      height: Sizing.heightByMQ(context, 0.8),
      margin: const EdgeInsets.only(top: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0.85, 0.85),
            child: CustomRoundButton(
              usePostQuery: usePostQuery,
              searchedMainCategory: searchedMainCategory.value,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectMainCategoryDropdown(
                  searchedMainCategory: searchedMainCategory.value,
                  onCategorySelected: (MainCategory? category) {
                    searchedMainCategory.value = category;
                  },
                ),
              ],
            ),
          ),
        ],
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
            hint: const Text("費目で検索"),
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

class CustomRoundButton extends HookConsumerWidget {
  const CustomRoundButton({
    super.key,
    required this.usePostQuery,
    required this.searchedMainCategory,
  });

  final ValueNotifier<PostQuery> usePostQuery;
  final MainCategory? searchedMainCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (searchedMainCategory == null) {
          return;
        }
        usePostQuery.value = PostQuery(
          type: PostQueryType.mainCategory,
          params: {
            PostQueryKey.mainCategory: searchedMainCategory.toString(),
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
