import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/nijimas_controller.dart';
import 'package:nijimas/controllers/post_controller.dart';
import 'package:nijimas/core/providers/nijimas_notifier_provider.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';
import 'package:nijimas/widgets/post/tag_chip.dart';
import 'package:toggle_switch/toggle_switch.dart';

//23:04
//リアルタイムで取得しない...

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useSelectedTags = useState<List<String>>([]);
    final useSelectedPhotos = useState<List<String>>([]);

    bool isPublic = true;

    final useTagController = useTextEditingController();
    final useTextController = useTextEditingController();

    final nijimas = ref.watch(nijimasProvider)!;
    final isLoading = ref.watch(postControllerProvider);

    void addTag(String tagName) {
      if (useSelectedTags.value.length < 3) {
        if (useSelectedTags.value.contains(tagName)) {
          showErrorSnackBar(context, "同じタグは登録できません。");
          return;
        }
        if (hasEmoji(tagName)) {
          showErrorSnackBar(context, "絵文字は登録できません。");
          return;
        }

        useSelectedTags.value = [...useSelectedTags.value, tagName];
      } else {
        showErrorSnackBar(context, "登録できるタグは3つまでです。");
      }
    }

    void removeTag(String tagName) {
      useSelectedTags.value =
          useSelectedTags.value.where((tag) => tag != tagName).toList();
    }

    void addPhoto(String photoPath) {
      if (useSelectedPhotos.value.length < 4) {
        useSelectedPhotos.value = [...useSelectedPhotos.value, photoPath];
      } else {
        showErrorSnackBar(context, "登録できる写真は4枚までです。");
      }
    }

    void removePhoto(String photoPath) {
      useSelectedPhotos.value =
          useSelectedPhotos.value.where((photo) => photo != photoPath).toList();
    }

    return isLoading
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(nijimas.section,
                  style: const TextStyle(color: Colors.black)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: TextField(
                      controller: useTagController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "タグを追加",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          if (value.length <= 20) {
                            addTag(value);
                            useTagController.clear();
                          } else {
                            showErrorSnackBar(context, "タグは20文字以内で入力してください。");
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: useSelectedTags.value.map((tag) {
                          return TagChip(
                            tagName: tag,
                            removeTag: (tagToRemove) => removeTag(tagToRemove),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ref.watch(getCurrentNijimasProvider(nijimas.section)).when(
                        data: (data) {
                          if (data[0].photos.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  viewportFraction: 0.92,
                                  enableInfiniteScroll: false,
                                ),
                                items: data[0].photos.map((photo) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (!useSelectedPhotos.value
                                              .contains(photo)) {
                                            addPhoto(photo);
                                          } else {
                                            removePhoto(photo);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          child: Stack(children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: double.infinity,
                                              child: ColorFiltered(
                                                colorFilter: useSelectedPhotos
                                                        .value
                                                        .contains(photo)
                                                    ? const ColorFilter.mode(
                                                        Colors.black54,
                                                        BlendMode.darken)
                                                    : const ColorFilter.mode(
                                                        Colors.transparent,
                                                        BlendMode.darken),
                                                child: Image.network(
                                                  photo,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    useSelectedPhotos.value
                                                            .contains(photo)
                                                        ? Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                                const Icon(
                                                                  Icons.circle,
                                                                  color: MyColors
                                                                      .lightGreen,
                                                                ),
                                                                Text(
                                                                  (useSelectedPhotos
                                                                              .value
                                                                              .indexOf(photo) +
                                                                          1)
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ])
                                                        : const Icon(
                                                            Icons
                                                                .check_circle_outline,
                                                            color: Colors.grey,
                                                          ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(4, (index) {
                                    if (index <
                                        useSelectedPhotos.value.length) {
                                      return const Icon(Icons.circle,
                                          color: MyColors.lightGreen);
                                    }
                                    return const Icon(
                                      Icons.circle_outlined,
                                      color: Colors.grey,
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () => const Loader(),
                        error: (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: TextField(
                      controller: useTextController,
                      maxLines: 6,
                      maxLength: 150,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "本文を入力",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    activeBgColor: const [MyColors.pinkColor],
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: const ['公開', '非公開'],
                    onToggle: (index) {
                      if (index == 0) {
                        isPublic = true;
                      } else {
                        isPublic = false;
                      }
                    },
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyColors.whiteColor,
              onPressed: () {
                if (useSelectedPhotos.value.isEmpty &&
                    useTextController.text.isEmpty) {
                  showErrorSnackBar(context, "写真を選択、またはテキストを入力してください。");
                  return;
                }
                ref.read(postControllerProvider.notifier).addPost(
                    context: context,
                    doneNijimas: nijimas,
                    isPublic: isPublic,
                    text: useTextController.text,
                    postPhotos: useSelectedPhotos.value,
                    tags: useSelectedTags.value);
              },
              child: const FaIcon(FontAwesomeIcons.plus,
                  color: MyColors.pinkColor),
            ),
          );
  }
}
