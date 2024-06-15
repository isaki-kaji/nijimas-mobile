import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';
import 'package:nijimas/core/util/sizing.dart';

class MemoInputField extends StatelessWidget {
  MemoInputField({
    super.key,
    required this.usePostFormData,
  });

  final ValueNotifier<PostFormData> usePostFormData;
  final useTextController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          onChanged: (value) {
            usePostFormData.value =
                usePostFormData.value.copyWith(postText: value);
          },
        ),
      ),
    );
  }
}
