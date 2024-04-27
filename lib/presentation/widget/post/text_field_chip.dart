import 'package:flutter/material.dart';

class TextFieldChip extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSubmit;
  const TextFieldChip({
    required this.controller,
    required this.onSubmit,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: IntrinsicWidth(
                child: TextFormField(
              maxLength: 50,
              onFieldSubmitted: onSubmit,
              controller: controller,
              decoration: const InputDecoration(
                  counterText: "",
                  hintText: "サブカテゴリを入力",
                  border: InputBorder.none),
            )),
          ),
        ),
      ),
    );
  }
}
