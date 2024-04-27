import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showTopErrorSnackBar(BuildContext context, String message) {
  showTopSnackBar(
      displayDuration: const Duration(seconds: 2),
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
}

void showSuccessSnackBar(BuildContext context, String message) {
  showTopSnackBar(
      displayDuration: const Duration(seconds: 2),
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
        backgroundColor: MyColors.lightGreen,
      ));
}
