import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/application/state/user_response_provider.dart';
import 'package:nijimas/core/theme/color.dart';
import 'package:nijimas/core/util/resize_image.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/presentation/widget/user/switch_circle_avatar.dart';

class UserEditScreen extends HookConsumerWidget {
  UserEditScreen({super.key, required this.uid});
  final String uid;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileInfoProvider(uid));
    final useNameController =
        useTextEditingController(text: user.valueOrNull!.username);
    final useSelfIntroController =
        useTextEditingController(text: user.valueOrNull!.selfIntro);
    final useIsSelectingImage = useState(false);
    final picker = ImagePicker();
    final useImageBitmap = useState<List<Uint8List>>([]);

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
      body: user.when(
        data: (data) {
          return Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  useImageBitmap.value.isEmpty
                      ? SwitchCircleAvatar(
                          imageUrl: data!.profileImageUrl,
                          radius: Sizing.widthByMQ(context, 0.2),
                          onTap: () => selectProfileImage(),
                        )
                      : GestureDetector(
                          onTap: () => selectProfileImage(),
                          child: CircleAvatar(
                            radius: Sizing.widthByMQ(context, 0.2),
                            backgroundImage:
                                MemoryImage(useImageBitmap.value[0]),
                          ),
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
                          return "名前を入力してください";
                        }
                        if (name.length < 2 || name.length > 15) {
                          return "2文字以上15文字以下で入力してください";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: Sizing.widthByMQ(context, 0.9),
                      child: TextFormField(
                        controller: useSelfIntroController,
                        maxLines: 6,
                        maxLength: 200,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "自己紹介を入力してください",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          );
        },
        error: (error, _) {
          return Center(child: Text(error.toString()));
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
              onPressed: () {
                final formState = _formKey.currentState!;
                formState.validate();
              },
            ),
    );
  }
}
