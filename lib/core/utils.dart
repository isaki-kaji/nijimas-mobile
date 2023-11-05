import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nijimas/core/theme/my_colors.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 2),
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
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        title: 'Success!',
        color: MyColors.lightGreen,
        message: message,
        contentType: ContentType.success,
      ),
    ));
}

void showMyDialog(BuildContext context, String title, String content,
    void Function() onPressed) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'OK',
              style: TextStyle(color: MyColors.pinkColor),
            ),
          ),
        ],
      );
    },
  );
}
