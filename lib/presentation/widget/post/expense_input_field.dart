import 'package:flutter/material.dart';

class ExpenseInputField extends StatelessWidget {
  const ExpenseInputField({
    super.key,
    required this.useExpenseController,
  });

  final TextEditingController useExpenseController;

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
