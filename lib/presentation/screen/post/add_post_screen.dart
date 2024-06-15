import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/enum/post_query.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isKeyboardShown = 0 < MediaQuery.of(context).viewInsets.bottom;
    final isLoading = ref.watch(loadingProvider);
    final useIsVisibleTextFieldChip = useState<bool>(false);
    final picker = ImagePicker();
    final useIsSelectingImage = useState(false);
    PostFormData initialFormData = PostFormData(
      mainCategory: MainCategory.food,
      subCategories: [],
      postText: "",
      images: [],
      expense: "",
      publicTypeNo: 0.toString(),
    );
    final usePostFormData = useState(initialFormData);
    PostFormData formData = usePostFormData.value;

    Future<void> selectImages() async {
      useIsSelectingImage.value = true;
      final List<XFile?> imageFiles = await picker.pickMultiImage(limit: 4);
      if (imageFiles.isEmpty) {
        useIsSelectingImage.value = false;
        return;
      }
      final result = await compute(resizeImages, imageFiles);
      formData = formData.copyWith(images: result);
      useIsSelectingImage.value = false;
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
                      ExpenseInputField(usePostFormData: usePostFormData),
                      CategoryInputField(
                        usePostFormData: usePostFormData,
                        useIsVisibleTextFieldChip: useIsVisibleTextFieldChip,
                      ),
                      if (formData.images.isNotEmpty)
                        ImageCarouselSlider(
                          isKeyboardShown: isKeyboardShown,
                          images: formData.images,
                          selectImages: selectImages,
                        )
                      else
                        ImageSelectDetector(
                            isKeyboardShown: isKeyboardShown,
                            selectImages: selectImages),
                      MemoInputField(usePostFormData: usePostFormData),
                      PublicTypeSwitch(usePostFormData: usePostFormData),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),

      /////////////////
      //登録パート
      /////////////////
      floatingActionButton: (isKeyboardShown || useIsSelectingImage.value)
          ? null
          : FloatingActionButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (formData.expense.isEmpty &&
                    formData.postText.isEmpty &&
                    formData.images.isEmpty) {
                  showErrorSnackBar(context, "金額、メモ、画像のいずれかを入力してください");
                  return;
                }
                final postUsecase = ref.read(postUsecaseProvider);
                await postUsecase.createPost(
                  formData: formData,
                  onSuccess: () {
                    showSuccessSnackBar(context, "成功しました");
                    final uid = ref.read(authStateProvider).value!.uid;
                    ref.invalidate(postsNotifierProvider(PostQuery(
                        type: PostQueryType.uid,
                        params: {PostQueryKey.uid: uid})));
                    GoRouter.of(context).pop();
                  },
                  onFailure: () {
                    showErrorSnackBar(context, "投稿に失敗しました");
                  },
                );
              },
              backgroundColor: MyColors.pink,
              child: const Icon(
                Icons.done,
                color: MyColors.white,
              ),
            ),
    );
  }
}
