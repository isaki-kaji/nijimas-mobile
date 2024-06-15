import 'package:flutter/material.dart';
import 'package:nijimas/application/formdata/post_form_data.dart';

class ExpenseInputField extends StatelessWidget {
  ExpenseInputField({
    super.key,
    required this.usePostFormData,
  });

  final ValueNotifier<PostFormData> usePostFormData;
  final useExpenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox.shrink(),
        ),
        Expanded(
          flex: 6,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
                return "金額を正しく入力してください";
              }
              if (int.parse(value) > 100000000) {
                return "お金持ちすぎます";
              }
              return null;
            },
            controller: useExpenseController,
            style: const TextStyle(fontSize: 40.0),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '00',
            ),
            onChanged: (value) {
              if (value.isNotEmpty &&
                  RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
                if (int.parse(value) <= 100000000) {
                  usePostFormData.value =
                      usePostFormData.value.copyWith(expense: value);
                }
              }
            },
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text("円"),
        ),
      ],
    );
  }
}
