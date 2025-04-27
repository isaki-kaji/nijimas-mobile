import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/sizing.dart';

class PostSearchDialog extends HookWidget {
  const PostSearchDialog({super.key, required this.onQuerySelected});

  final void Function(PostQuery) onQuerySelected;

  @override
  Widget build(BuildContext context) {
    // useState を使用してサブカテゴリの状態を管理
    final searchedSubCategory = useState<String?>(null);

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectSubCategoryField(
              onCategorySelected: (value) {
                searchedSubCategory.value = value;
              },
            ),
          ],
        ),
      ),
      actions: [
        CustomRoundButton(
          searchedSubCategory: searchedSubCategory.value,
          onQuerySelected: onQuerySelected,
        ),
      ],
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
    required this.onCategorySelected,
  });

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

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({
    super.key,
    required this.searchedSubCategory,
    required this.onQuerySelected,
  });

  final String? searchedSubCategory;
  final void Function(PostQuery) onQuerySelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchedSubCategory == null || searchedSubCategory!.isEmpty) {
          Navigator.of(context).pop();
          return;
        }

        final newQuery = PostQuery(
          type: PostQueryType.subCategory,
          params: {PostQueryKey.subCategory: searchedSubCategory!},
        );

        onQuerySelected(newQuery); // クエリを渡す
        Navigator.of(context).pop(); // ダイアログを閉じる
      },
      child: const SubButton(icon: Icons.search),
    );
  }
}

class SubButton extends StatelessWidget {
  final IconData icon;
  const SubButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Icon(icon, color: MyColors.white),
    );
  }
}
