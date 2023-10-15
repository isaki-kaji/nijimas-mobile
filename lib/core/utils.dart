import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Oh no!',
        color: MyColors.pinkColor,
        message: message,
        contentType: ContentType.failure,
      ),
    ));
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Success!',
        color: MyColors.lightGreen,
        message: message,
        contentType: ContentType.success,
      ),
    ));
}
