import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/core/provider/usecase/auth_usecase_provider.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/gen/assets.gen.dart';
import 'package:nijimas/presentation/widget/auth/signin_button.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';
import 'package:nijimas/core/util/sizing.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () => ref.read(authUsecaseProvider).signInAsGuest(),
              child: const Text("skip"))
        ],
      ),
      body: isLoading
          ? const Loader()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.title.image(width: Sizing.widthByMQ(context, 1.0)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Assets.nijimas.image(
                      height: Sizing.heightByMQ(context, 0.45),
                    ),
                  ),
                  SignInButton(
                    labelText: "Continue With Google",
                    type: "google",
                    logo: Assets.google.image(width: 35),
                    onFailure: () =>
                        showErrorSnackBar(context, "Google認証に失敗しました"),
                  ),
                  SignInButton(
                    labelText: "Continue with Apple",
                    type: "apple",
                    logo: const Icon(
                      Icons.apple,
                      color: Colors.black,
                      size: 35,
                    ),
                    onFailure: () =>
                        showErrorSnackBar(context, "Google認証に失敗しました"),
                  ),
                  SizedBox(height: Sizing.heightByMQ(context, 0.05)),
                ],
              ),
            ),
    );
  }
}
