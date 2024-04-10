import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/core/util/snack_bar.dart';

class SignInButton extends ConsumerWidget {
  final String labelText;
  final String type;
  final Widget logo;
  const SignInButton(
      {super.key,
      required this.labelText,
      required this.type,
      required this.logo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          final usecase = ref.read(authUsecaseProvider);
          if (type == "google") {
            await usecase.signInWithGoogle(onFailure: () {
              showTopErrorSnackBar(context, "Googleサインインに失敗しました");
            });
          }
        },
        icon: logo,
        label: Text(
          labelText,
          style: const TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(width: 0.2)),
        ),
      ),
    );
  }
}
