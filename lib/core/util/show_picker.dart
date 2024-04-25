import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:nijimas/core/constant/main_category_constant.dart';

void showPicker(BuildContext context, void Function(String) tapEvent) {
  Picker picker = Picker(
      height: 300.0,
      adapter: PickerDataAdapter<String>(pickerData: mainCategoryNames()),
      changeToFirst: true,
      textAlign: TextAlign.left,
      itemExtent: 50.0,
      textStyle: const TextStyle(color: Colors.black, fontSize: 30),
      onConfirm: (Picker picker, List value) {
        tapEvent(picker.getSelectedValues().first);
      });
  picker.showModal(context);
}
