import 'package:flutter/material.dart';
import 'package:nijimas/core/util/sizing.dart';

class MemoInputField extends StatelessWidget {
  const MemoInputField({
    super.key,
    required this.useTextController,
  });

  final TextEditingController useTextController;

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
        ),
      ),
    );
  }
}
