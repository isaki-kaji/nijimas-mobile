import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/core/util/show_picker.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';
import 'package:nijimas/presentation/widget/post/text_field_chip.dart';

class CategoryInputField extends StatelessWidget {
  CategoryInputField({
    super.key,
    required this.usePostFormData,
    required this.useIsVisibleTextFieldChip,
  });

  final ValueNotifier<PostFormData> usePostFormData;
  final ValueNotifier<bool> useIsVisibleTextFieldChip;
  final subCategoryTextController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    PostFormData formData = usePostFormData.value;

    void removeSubCategory(String subCategory) {
      usePostFormData.value = usePostFormData.value.copyWith(
        subCategories: usePostFormData.value.subCategories
            .where((s) => s != subCategory)
            .toList(),
      );
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
                category: formData.mainCategory,
                tapEvent: (s) => showPicker(context, (s) {
                  usePostFormData.value =
                      usePostFormData.value.copyWith(mainCategory: s);
                }),
              ),
              ...formData.subCategories.map((s) {
                return SubCategoryChip(
                  categoryName: s,
                  tapEvent: (s) => removeSubCategory(s),
                );
              }),
              if (formData.subCategories.length < 2)
                useIsVisibleTextFieldChip.value
                    ? TextFieldChip(
                        controller: subCategoryTextController,
                        onSubmit: (_) {
                          if (subCategoryTextController.text.isEmpty) {
                            useIsVisibleTextFieldChip.value = false;
                            return;
                          }
                          final newSubCategory = subCategoryTextController.text;

                          if (formData.subCategories.contains(newSubCategory)) {
                            useIsVisibleTextFieldChip.value = false;
                            subCategoryTextController.clear();
                            return;
                          }

                          usePostFormData.value =
                              usePostFormData.value.copyWith(
                            subCategories: List.from(formData.subCategories)
                              ..add(newSubCategory),
                          );

                          useIsVisibleTextFieldChip.value = false;
                          subCategoryTextController.clear();
                        },
                      )
                    : IconButton(
                        onPressed: () {
                          useIsVisibleTextFieldChip.value = true;
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
