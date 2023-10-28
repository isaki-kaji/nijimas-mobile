import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nijimas/controllers/nijimas_controller.dart';
import 'package:nijimas/core/theme/text_styles.dart';
import 'package:nijimas/test/test_data.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';

class TakePhotoScreen extends HookConsumerWidget {
  const TakePhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _photo = useState<XFile?>(null);
    final picker = ImagePicker();

    final currentNijimas =
        ref.watch(getCurrentNijimasProvider(TestData.section));

    useEffect(() {
      Future takePhoto() async {
        final photo = await picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          _photo.value = photo;
        }
      }

      takePhoto();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: currentNijimas.when(
            data: (data) {
              return Text(data[0].section, style: TextStyles.appBarTitle());
            },
            loading: () => const Loader(),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
          )),
      body: _photo.value == null
          ? const Text('No photo taken yet.')
          : Image.file(File(_photo.value!.path)),
    );
  }
}
