import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

void showPicker(BuildContext context, void Function(String) tapEvent) {
  Picker picker = Picker(
      height: 300.0,
      adapter: PickerDataAdapter<String>(
          pickerData: ["食事", "交際", "趣味", "交通", "その他"]),
      changeToFirst: true,
      textAlign: TextAlign.left,
      itemExtent: 50.0,
      textStyle: const TextStyle(color: Colors.black, fontSize: 30),
      onConfirm: (Picker picker, List value) {
        tapEvent(picker.getSelectedValues().first);
      });
  picker.showModal(context);
}
