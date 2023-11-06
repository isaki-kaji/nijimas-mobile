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

bool hasEmoji(String input) {
  final RegExp emojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}'
    r'\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{2600}-\u{26FF}'
    r'\u{2700}-\u{27BF}\u{2B50}-\u{2BFF}]',
    unicode: true,
  );

  return emojiRegex.hasMatch(input);
}
