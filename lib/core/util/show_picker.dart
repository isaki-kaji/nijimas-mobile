import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/enum/main_category.dart';
import 'package:nijimas/core/theme/my_color.dart';

// void showPicker(BuildContext context, void Function(String) tapEvent) {
//   Picker picker = Picker(
//       height: 300.0,
//       adapter: PickerDataAdapter<String>(pickerData: mainCategoryNames()),
//       changeToFirst: true,
//       textAlign: TextAlign.left,
//       itemExtent: 50.0,
//       textStyle: const TextStyle(color: Colors.black, fontSize: 30),
//       onConfirm: (Picker picker, List value) {
//         tapEvent(picker.getSelectedValues().first);
//       });
//   picker.showModal(context);
// }

void showPicker(BuildContext context, void Function(String) tapEvent) {
  BottomPicker(
    pickerTitle: const SizedBox.shrink(),
    height: 300.0,
    buttonContent: const Icon(Icons.check, color: MyColors.white),
    buttonSingleColor: MyColors.lightGreen,
    items: mainCategoryNames()
        .map((name) => Text(name,
            style: const TextStyle(color: Colors.black, fontSize: 30)))
        .toList(),
    dismissable: true,
    itemExtent: 50.0,
    onSubmit: (index) {
      tapEvent(mainCategoryNames()[index]);
    },
  ).show(context);
}
