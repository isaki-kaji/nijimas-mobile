import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/util/resize_image.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/post/category_input_field.dart';
import 'package:nijimas/presentation/widget/post/expense_input_field.dart';
import 'package:nijimas/presentation/widget/post/image_carousel_slider.dart';
import 'package:nijimas/presentation/widget/post/image_selector_detector.dart';
import 'package:nijimas/presentation/widget/post/memo_input_field.dart';
import 'package:nijimas/presentation/widget/post/public_type_switch.dart';

class AddPostScreen extends HookConsumerWidget {
  AddPostScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isKeyboardShown = 0 < MediaQuery.of(context).viewInsets.bottom;
    final isLoading = ref.watch(loadingProvider);
    final useMainCategory = useState<String>(MainCategory.food.name);
    final useSubCategories = useState<List<String>>([]);
    final useIsVisibleTextFieldChip = useState<bool>(false);
    final usePublicTypeNo = useState<int>(0);
    final subCategoryTextController = useTextEditingController();
    final useMemoController = useTextEditingController();
    final useExpenseController = useTextEditingController();
    final useImageBitmap = useState<List<Uint8List?>>([]);

    Future<void> selectImages() async {
      final List<XFile?> imageFiles = await picker.pickMultiImage(limit: 4);
      if (imageFiles.isEmpty) {
        return;
      }
      final result = await compute(resizeImages, imageFiles);
      useImageBitmap.value = result;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30.0,
          icon: const Icon(Icons.close),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          TrailingIconButton(onPressed: () {}, icon: Icons.help_outline),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Form(
              key: _formKey,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExpenseInputField(
                          useExpenseController: useExpenseController),
                      CategoryInputField(
                          useMainCategory: useMainCategory,
                          useSubCategories: useSubCategories,
                          useIsVisibleTextFieldChip: useIsVisibleTextFieldChip,
                          subCategoryTextController: subCategoryTextController),
                      if (useImageBitmap.value.isNotEmpty)
                        ImageCarouselSlider(
                          isKeyboardShown: isKeyboardShown,
                          useImageBitmap: useImageBitmap,
                          selectImages: selectImages,
                        )
                      else
                        ImageSelectDetector(
                            isKeyboardShown: isKeyboardShown,
                            selectImages: selectImages),
                      MemoInputField(useTextController: useMemoController),
                      PublicTypeSwitch(usePublicTypeNo: usePublicTypeNo),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),

      /////////////////
      //登録パート
      /////////////////
      floatingActionButton: isKeyboardShown
          ? null
          : FloatingActionButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (useExpenseController.text.isEmpty &&
                    useMemoController.text.isEmpty &&
                    useImageBitmap.value.isEmpty) {
                  showTopErrorSnackBar(context, "金額、メモ、画像のいずれかを入力してください");
                  return;
                }
                final formData = PostFormData(
                  mainCategory: useMainCategory.value,
                  subCategories: useSubCategories.value,
                  postText: useMemoController.text,
                  expense: useExpenseController.text,
                  images: useImageBitmap.value,
                  publicTypeNo: (usePublicTypeNo.value + 1).toString(),
                );
                print(formData.toString());
                final postUsecase = ref.read(postUsecaseProvider);
                await postUsecase.createPost(
                  formData: formData,
                  onSuccess: () {
                    showSuccessSnackBar(context, "成功しました");
                    GoRouter.of(context).pop();
                  },
                  onFailure: () {
                    showTopErrorSnackBar(context, "投稿に失敗しました");
                  },
                );
              },
              backgroundColor: MyColors.pink,
              child: const Icon(
                Icons.post_add_rounded,
                color: MyColors.white,
              ),
            ),
    );
  }
}
