import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/controllers/nijimas_controller.dart';
import 'package:nijimas/core/providers/nijimas_notifier_provider.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';
import 'package:nijimas/widgets/post/tag_chip.dart';

class AddPostScreen extends HookConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useSelectedTags = useState<List<String>>([]);
    final useSelectedPhotos = useState<List<String>>([]);

    final useTagController = useTextEditingController();

    final nijimas = ref.watch(nijimasProvider)!.section;

    void addTag(String tagName) {
      if (useSelectedTags.value.length < 3) {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(nijimas, style: const TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
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
          ref.watch(getCurrentNijimasProvider(nijimas)).when(
                data: (data) {
                  if (data[0].photos.isEmpty) {
                    return const SizedBox();
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.3,
                      viewportFraction: 0.9,
                      enableInfiniteScroll: false,
                    ),
                    items: data[0].photos.map((photo) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              if (!useSelectedPhotos.value.contains(photo)) {
                                addPhoto(photo);
                              } else {
                                removePhoto(photo);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                child: Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
                loading: () => const Loader(),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (index) {
                if (index < useSelectedPhotos.value.length) {
                  return const Icon(Icons.circle, color: MyColors.lightGreen);
                }
                return const Icon(
                  Icons.circle_outlined,
                  color: Colors.grey,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
