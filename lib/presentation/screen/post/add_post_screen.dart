import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/util/resize_image.dart';
import 'package:nijimas/core/util/show_picker.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/common/trailing_icon_button.dart';
import 'package:nijimas/presentation/widget/post/main_category_chip.dart';
import 'package:nijimas/presentation/widget/post/sub_category_chip.dart';
import 'package:nijimas/presentation/widget/post/text_field_chip.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isKeyboardShown = 0 < MediaQuery.of(context).viewInsets.bottom;
    final imageHeight = Sizing.heightByMQ(context, 0.2);
    final imageWidth = Sizing.widthByMQ(context, 0.6);
    final useMainCategory = useState<String>(MainCategory.food.name);
    final useSelectedSubCategories = useState<List<String>>([]);
    final useIsVisibleTextFieldChip = useState<bool>(false);
    final usePublicTypeNo = useState<int>(0);
    final subCategoryTextController = useTextEditingController();
    final useTextController = useTextEditingController();
    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List?>>([]);

    Future<void> selectImages() async {
      final List<XFile?> imageFiles = await picker.pickMultiImage(limit: 4);
      if (imageFiles.isEmpty) {
        return;
      }
      final result = await compute(resizeImages, imageFiles);
      useImageBitmap.value = result;
    }

    void removeSubCategory(String subCategory) {
      useSelectedSubCategories.value = useSelectedSubCategories.value
          .where((s) => s != subCategory)
          .toList();
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
      body: Form(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /////////////////
                //費用入力パート
                /////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 40.0),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '00',
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text("円"),
                    ),
                  ],
                ),

                /////////////////
                //カテゴリ選択パート
                /////////////////
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainCategoryChip(
                                categoryName: useMainCategory.value,
                                tapEvent: (s) => showPicker(context, (s) {
                                      useMainCategory.value = s;
                                    })),
                            ...useSelectedSubCategories.value.map((s) {
                              return SubCategoryChip(
                                  categoryName: s,
                                  tapEvent: (s) => removeSubCategory(s));
                            }),
                            if (useSelectedSubCategories.value.length < 2)
                              useIsVisibleTextFieldChip.value
                                  ? TextFieldChip(
                                      controller: subCategoryTextController,
                                      onSubmit: (_) {
                                        if (subCategoryTextController
                                            .text.isEmpty) {
                                          useIsVisibleTextFieldChip.value =
                                              false;
                                          return;
                                        }
                                        useSelectedSubCategories.value.add(
                                            subCategoryTextController.text);
                                        useIsVisibleTextFieldChip.value = false;
                                        subCategoryTextController.clear();
                                      },
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        useIsVisibleTextFieldChip.value = true;
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_outline))
                          ],
                        ),
                      ),
                    )),

                /////////////////
                //画像選択パート
                /////////////////
                if (useImageBitmap.value.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      if (isKeyboardShown) {
                        FocusScope.of(context).unfocus();
                        return;
                      }
                      selectImages();
                    },
                    child: CarouselSlider(
                        items: useImageBitmap.value.map((i) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: SizedBox(
                              height: imageHeight,
                              width: imageWidth,
                              child: Image.memory(i!, fit: BoxFit.cover),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          height: imageHeight,
                          viewportFraction: 0.6,
                        )),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      if (isKeyboardShown) {
                        FocusScope.of(context).unfocus();
                        return;
                      }
                      selectImages();
                    },
                    child: DottedBorder(
                      color: Theme.of(context).colorScheme.secondary,
                      dashPattern: const [6, 6],
                      strokeWidth: 2.0,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12.0),
                      child: SizedBox(
                        height: imageHeight,
                        width: Sizing.widthByMQ(context, 0.8),
                        child: Icon(
                          Icons.camera_alt,
                          size: 50.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),

                /////////////////
                //メモ入力パート
                /////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: Sizing.widthByMQ(context, 0.9),
                    child: TextFormField(
                      controller: useTextController,
                      maxLines: 6,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "メモを入力",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),

                /////////////////
                //公開設定パート
                /////////////////
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Scrollbar(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ToggleSwitch(
                        initialLabelIndex: usePublicTypeNo.value,
                        totalSwitches: 3,
                        customWidths: const [80, 200, 80],
                        customTextStyles: const [
                          TextStyle(fontWeight: FontWeight.w500)
                        ],
                        activeBgColor: const [MyColors.lightGreen],
                        inactiveBgColor:
                            Theme.of(context).colorScheme.surfaceVariant,
                        labels: const ["公開", "フォロワーにのみ公開", "非公開"],
                        onToggle: (i) {
                          usePublicTypeNo.value = i!;
                        },
                      ),
                    ),
                  ),
                ),
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
              onPressed: () {},
              backgroundColor: MyColors.pink,
              child: const Icon(
                Icons.done,
                color: MyColors.white,
              ),
            ),
    );
  }
}
