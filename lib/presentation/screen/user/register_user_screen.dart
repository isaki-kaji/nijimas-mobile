import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n//app_localizations.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/core/constant/animation_constant.dart';
import 'package:nijimas/core/provider/usecase/user_usecase_provider.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/core/util/sizing.dart';
import 'package:nijimas/core/util/show_snack_bar.dart';
import 'package:nijimas/presentation/widget/common/loader.dart';

class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final isLoading = ref.watch(loadingProvider);
    final usernameController = useTextEditingController();
    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 500),
        initialValue: AnimationConstants.defaultWaveHeight,
        upperBound: AnimationConstants.upperWaveHeight);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        GoRouter.of(context).go('/', extra: true);
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Sizing.heightByMQ(context, 0.18),
                  ),
                  Text(l10n.welcome,
                      style: MyTextStyle.bigTitle(
                          context, Theme.of(context).colorScheme.secondary)),
                  SizedBox(
                    height: Sizing.heightByMQ(context, 0.15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: l10n.enterYourName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.nameCanBeChanged,
                        style: MyTextStyle.caption.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final nameValue = usernameController.text;
                        if (nameValue.length < 3 || nameValue.length > 15) {
                          showTopErrorSnackBar(context, l10n.enterNameCaption);
                          return;
                        }
                        final locale = Localizations.localeOf(context);
                        ref.read(userUsecaseProvider).createUser(
                            request: CreateUserRequest(
                                uid: ref
                                    .read(authStateProvider)
                                    .valueOrNull!
                                    .uid,
                                username: nameValue,
                                countryCode: locale.countryCode),
                            onSuccess: () {
                              animationController.forward();
                            },
                            onFailure: () {
                              showTopErrorSnackBar(
                                  context, l10n.failedToCreateUser);
                            },
                            onUserAlreadyExists: () {
                              showTopErrorSnackBar(
                                  context, l10n.userAlreadyExists);
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(Icons.check),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CustomWave(
            waveColor: MyColors.getWaveColors(),
            waveHeight: Sizing.heightByMQ(context, animationController.value),
          );
        },
      ),
    );
  }
}
