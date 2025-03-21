import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/application/formdata/user_form_data.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/state/posts_provider.dart';
import 'package:nijimas/application/state/user_detail_provider.dart';
import 'package:nijimas/application/state/user_provider.dart';
import 'package:nijimas/core/model/user_top_subcategory.dart';
import 'package:nijimas/core/provider/usecase/user_usecase_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/resize_image.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/l10n/gen_l10n/app_localizations.dart';
import 'package:nijimas/presentation/widget/common/error_message.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/user/add_used_subcategory_bottom_sheet.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class UserEditScreen extends HookConsumerWidget {
  UserEditScreen({super.key, required this.uid});
  final String uid;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final isLoading = ref.watch(loadingProvider);
    final user = ref.watch(appUserProvider);
    final useNameController = useTextEditingController();
    final useSelfIntroController = useTextEditingController();
    final useIsSelectingImage = useState(false);
    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List>>([]);

    useEffect(() {
      if (user.valueOrNull != null) {
        useNameController.text = user.valueOrNull!.username;
        useSelfIntroController.text = user.valueOrNull!.selfIntro ?? '';
      }
      return null;
    }, [user.valueOrNull]);

    Future<void> selectProfileImage() async {
      useIsSelectingImage.value = true;
      final XFile? imageFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageFile == null) {
        useIsSelectingImage.value = false;
        return;
      }
      final result = await compute(resizeImages, [imageFile]);
      useImageBitmap.value = result;
      useIsSelectingImage.value = false;
    }

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : user.when(
              data: (data) {
                return Form(
                  key: _formKey,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                useImageBitmap.value.isEmpty
                                    ? SwitchCircleAvatar(
                                        imageUrl: data.profileImageUrl,
                                        radius: Sizing.widthByMQ(context, 0.2),
                                        onTap: () => selectProfileImage(),
                                      )
                                    : GestureDetector(
                                        onTap: () => selectProfileImage(),
                                        child: CircleAvatar(
                                          radius:
                                              Sizing.widthByMQ(context, 0.2),
                                          backgroundImage: MemoryImage(
                                              useImageBitmap.value[0]),
                                        ),
                                      ),
                                const Stack(children: [
                                  Icon(Icons.circle,
                                      color: MyColors.white, size: 50),
                                  Icon(Icons.change_circle,
                                      color: MyColors.lightGreen, size: 50),
                                ]),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 80,
                              width: Sizing.widthByMQ(context, 0.6),
                              child: TextFormField(
                                controller: useNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return l10n.enterName;
                                  }
                                  if (name.length < 2 || name.length > 15) {
                                    return l10n.enterNameCaption;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: SizedBox(
                                width: Sizing.widthByMQ(context, 0.9),
                                child: TextFormField(
                                  controller: useSelfIntroController,
                                  maxLines: 6,
                                  maxLength: 200,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: l10n.enterSelfIntro,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(18),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              error: (error, s) {
                return ErrorMessage(message: l10n.errorOccurred);
              },
              loading: () {
                return const Center(child: Loader());
              },
            ),
      floatingActionButton: useIsSelectingImage.value
          ? null
          : FloatingActionButton(
              backgroundColor: MyColors.pink,
              child: const Icon(
                Icons.done,
                color: MyColors.white,
              ),
              onPressed: () async {
                final formState = _formKey.currentState!;
                if (formState.validate()) {
                  final formData = UserFormData(
                    username: useNameController.text,
                    selfIntro: useSelfIntroController.text,
                    profileImage: useImageBitmap.value.isNotEmpty
                        ? useImageBitmap.value[0]
                        : null,
                  );

                  final userUsecase = ref.read(userUsecaseProvider);
                  await userUsecase.updateUser(
                    formData: formData,
                    profileImageUrl: user.valueOrNull!.profileImageUrl,
                    version: user.valueOrNull!.version,
                    onSuccess: () {
                      showSuccessSnackBar(context, l10n.updatedProfile);
                      ref.invalidate(userDetailNotifierProvider(uid));
                      ref.invalidate(postsNotifierProvider);
                      GoRouter.of(context).pop();
                    },
                    onFailure: () =>
                        showErrorSnackBar(context, l10n.failedUpdateProfile),
                  );
                }
              },
            ),
    );
  }
}

Future<dynamic> showSelectTopSubcategoriesModal(
    BuildContext context, List<UserTopSubCategory> categories) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: AddUsedSubcategoryBottomSheet(
          topSubCategories: categories,
        ),
      );
    },
  );
}

class ScrollableSubCategoryChip extends StatelessWidget {
  const ScrollableSubCategoryChip({
    super.key,
    required this.categoryName,
  });
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(30),
              right: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryName,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
