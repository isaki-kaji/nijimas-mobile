import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/core/router/navigator.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:routemaster/routemaster.dart';

class SignInButton extends ConsumerWidget {
  String labelText;
  Widget logo;
  SignInButton({super.key, required this.labelText, required this.logo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigators.toHome(context);
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
