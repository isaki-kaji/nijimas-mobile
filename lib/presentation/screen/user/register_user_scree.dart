import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n//app_localizations.dart';
import 'package:nijimas/application/state/app_user_provider.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/presentation/widget/common/custom_wave.dart';
import 'package:nijimas/util/sizing.dart';
import 'package:nijimas/util/snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    Locale locale = Localizations.localeOf(context);
    final useUsernameController = useTextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
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
                controller: useUsernameController,
                decoration: InputDecoration(
                  hintText: l10n.enterYourName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.nameCanBeChanged,
                  style: MyTextStyle.caption
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // print(locale.toString());
                  // final nameValue = useUsernameController.text;
                  // if (nameValue.isEmpty) {
                  //   print("からです");
                  //   return;
                  // }
                  // if (nameValue.length < 3 || nameValue.length > 15) {
                  //   showTopErrorSnackBar(context, l10n.enterNameCaption);
                  //   return;
                  // }
                  // ref.read(appUserProvider.notifier).createUser(
                  //     CreateUserRequest(
                  //         uid: ref
                  //             .read(appUserProvider.notifier)
                  //             .getCurrentUser()!
                  //             .uid,
                  //         username: nameValue,
                  //         country: locale.toString()));
                  ref.read(authUsecaseProvider).signOut();
                  print(ref.read(authStateProvider));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.check),
              ),
            )
          ],
        ),
        bottomSheet: CustomWave(
          waveColor: MyColor.getWaveColors(),
          waveHeight: Sizing.heightByMQ(context, 0.3),
        ));
  }
}
