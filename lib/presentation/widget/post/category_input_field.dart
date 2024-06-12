import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/util/show_picker.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';
import 'package:nijimas/presentation/widget/post/text_field_chip.dart';

class CategoryInputField extends StatelessWidget {
  const CategoryInputField({
    super.key,
    required this.useMainCategory,
    required this.useSubCategories,
    required this.useIsVisibleTextFieldChip,
    required this.subCategoryTextController,
  });

  final ValueNotifier<MainCategory> useMainCategory;
  final ValueNotifier<List<String>> useSubCategories;
  final ValueNotifier<bool> useIsVisibleTextFieldChip;
  final TextEditingController subCategoryTextController;

  @override
  Widget build(BuildContext context) {
    void removeSubCategory(String subCategory) {
      useSubCategories.value =
          useSubCategories.value.where((s) => s != subCategory).toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainCategoryChip(
                  category: useMainCategory.value,
                  tapEvent: (s) => showPicker(context, (s) {
                        useMainCategory.value = s;
                      })),
              ...useSubCategories.value.map((s) {
                return SubCategoryChip(
                    categoryName: s, tapEvent: (s) => removeSubCategory(s));
              }),
              if (useSubCategories.value.length < 2)
                useIsVisibleTextFieldChip.value
                    ? TextFieldChip(
                        controller: subCategoryTextController,
                        onSubmit: (_) {
                          if (subCategoryTextController.text.isEmpty) {
                            useIsVisibleTextFieldChip.value = false;
                            return;
                          }
                          if (useSubCategories.value.length == 1) {
                            if (useSubCategories.value[0] ==
                                subCategoryTextController.text) {
                              useIsVisibleTextFieldChip.value = false;
                              subCategoryTextController.clear();
                              return;
                            }
                          }
                          useSubCategories.value
                              .add(subCategoryTextController.text);
                          useIsVisibleTextFieldChip.value = false;
                          subCategoryTextController.clear();
                        },
                      )
                    : IconButton(
                        onPressed: () {
                          useIsVisibleTextFieldChip.value = true;
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      )
            ],
          ),
        ),
      ),
    );
  }
}
