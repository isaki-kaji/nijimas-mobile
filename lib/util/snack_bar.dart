import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showTopErrorSnackBar(BuildContext context, String message) {
  showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
}
