import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/cotrollers/auth_controller.dart';

class SignInButton extends ConsumerWidget {
  final String labelText;
  final String type;
  final Widget logo;
  const SignInButton(
      {super.key,
      required this.labelText,
      required this.type,
      required this.logo});

  void signInWithGoogle(BuildContext context, WidgetRef ref) async {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () {
          if (type == "google") {
            signInWithGoogle(context, ref);
          }
        },
        icon: logo,
        label: Text(
          labelText,
          style: const TextStyle(fontSize: 18, color: MyColors.greyColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.whiteColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: MyColors.greyColor, width: 0.2)),
        ),
      ),
    );
  }
}
