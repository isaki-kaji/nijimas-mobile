import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/controllers/auth_controller.dart';
import 'package:nijimas/widgets/common/loader.dart';
import 'package:nijimas/widgets/auth/sign_in_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => signInAsGuest(ref, context),
              child: const Text("skip"))
        ],
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Image.asset(Constants.nijimasTitlePath, height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(Constants.nijimasLogoPath,
                        height: MediaQuery.of(context).size.height * 0.45),
                  ),
                  Column(
                    children: [
                      SignInButton(
                          labelText: "Continue with Google",
                          type: "google",
                          logo: Image.asset(
                            Constants.googleLogoPath,
                            width: 35,
                          )),
                      if (Platform.isIOS)
                        const SignInButton(
                          labelText: "Continue with Apple",
                          type: "apple",
                          logo: Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
