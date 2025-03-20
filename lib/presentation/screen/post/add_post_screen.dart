import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/state/monthly_summary_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/model/post.dart';
import 'package:nijimas/core/provider/usecase/post_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/resize_image.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/post/category_input_field.dart';
import 'package:nijimas/presentation/widget/post/custom_dotted_border.dart';
import 'package:nijimas/presentation/widget/post/expense_input_field.dart';
import 'package:nijimas/presentation/widget/post/image_carousel_slider.dart';
import 'package:nijimas/presentation/widget/post/image_selector_detector.dart';
import 'package:nijimas/presentation/widget/post/memo_input_field.dart';
import 'package:nijimas/presentation/widget/post/public_type_switch.dart';

class AddPostScreen extends HookConsumerWidget {
  AddPostScreen({super.key, this.editingPost});

  final Post? editingPost;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final isEditing = editingPost != null;
    bool isKeyboardShown = 0 < MediaQuery.of(context).viewInsets.bottom;
    final isLoading = ref.watch(loadingProvider);
    final useComputeLoading = useState<bool>(false);

    final useMainCategory = useState<MainCategory>(isEditing
        ? MainCategory.fromName(editingPost!.mainCategory)
        : MainCategory.food);

    final List<String> currentSubCategories = isEditing
        ? [editingPost!.subCategory1, editingPost!.subCategory2]
            .where((e) => e != null)
            .cast<String>()
            .toList()
        : [];
    final useSubCategories = useState<List<String>>(currentSubCategories);
    final useIsVisibleTextFieldChip = useState<bool>(false);

    final usePublicTypeNo =
        useState<int>(isEditing ? int.parse(editingPost!.publicTypeNo) : 0);

    final subCategoryTextController =
        useTextEditingController(text: isEditing ? '' : '');
    final useTextController =
        useTextEditingController(text: isEditing ? editingPost!.postText : '');
    final useExpenseController = useTextEditingController(
        text: isEditing
            ? double.parse(editingPost!.expense).toInt().toString()
            : '');

    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List?>>([]);
    final useIsSelectingImage = useState<bool>(false);

    Future<void> selectImages() async {
      useIsSelectingImage.value = true;
      final List<XFile?> imageFiles = await picker.pickMultiImage(limit: 4);
      if (imageFiles.isEmpty) {
        useIsSelectingImage.value = false;
        return;
      }
      useComputeLoading.value = true;
      final result = await compute(resizeImages, imageFiles);
      useImageBitmap.value = result;
      useComputeLoading.value = false;
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
                      ExpenseInputField(
                          useExpenseController: useExpenseController),
                      CategoryInputField(
                          useMainCategory: useMainCategory,
                          useSubCategories: useSubCategories,
                          useIsVisibleTextFieldChip: useIsVisibleTextFieldChip,
                          subCategoryTextController: subCategoryTextController),
                      useComputeLoading.value
                          ? const CustomDottedBorder(item: NewtonLoader())
                          : (useImageBitmap.value.isNotEmpty)
                              ? ImageCarouselSlider(
                                  isKeyboardShown: isKeyboardShown,
                                  useImageBitmap: useImageBitmap,
                                  selectImages: selectImages,
                                )
                              : ImageSelectDetector(
                                  isKeyboardShown: isKeyboardShown,
                                  selectImages: selectImages),
                      MemoInputField(useTextController: useTextController),
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
      floatingActionButton: (isKeyboardShown || useIsSelectingImage.value)
          ? null
          : FloatingActionButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (useExpenseController.text.isEmpty &&
                    useTextController.text.isEmpty &&
                    useImageBitmap.value.isEmpty) {
                  showErrorSnackBar(context, l10n.pleaseEnterPostInfo);
                  return;
                }
                final formData = PostFormData(
                  mainCategory: useMainCategory.value.name,
                  subCategories: useSubCategories.value,
                  postText: useTextController.text,
                  expense: useExpenseController.text,
                  images: useImageBitmap.value,
                  publicTypeNo: (usePublicTypeNo.value).toString(),
                );
                final postUsecase = ref.read(postUsecaseProvider);
                if (!isEditing) {
                  await postUsecase.createPost(
                    formData: formData,
                    onSuccess: () {
                      showSuccessSnackBar(context, l10n.postSuccess);
                      ref.invalidate(postsNotifierProvider);
                      ref.invalidate(monthlySummaryPresentationProvider(
                          DateTime.now().year.toString(),
                          DateTime.now().month.toString()));
                      GoRouter.of(context).pop();
                    },
                    onFailure: () {
                      showErrorSnackBar(context, l10n.postFailed);
                    },
                  );
                } else {
                  await postUsecase.updatePost(
                    postId: editingPost!.postId,
                    version: editingPost!.version,
                    formData: formData,
                    currentPostUrls: editingPost!.photoUrl,
                    onSuccess: () {
                      showSuccessSnackBar(
                        context,
                        l10n.updateSuccess,
                      );
                      ref.invalidate(postsNotifierProvider);
                      ref.invalidate(monthlySummaryPresentationProvider(
                          DateTime.now().year.toString(),
                          DateTime.now().month.toString()));
                      GoRouter.of(context).pop();
                    },
                    onFailure: () {
                      showErrorSnackBar(context, l10n.updateFailed);
                    },
                  );
                }
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
