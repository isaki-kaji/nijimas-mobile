import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n//app_localizations.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/util/sizing.dart';

class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final useUsernameController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Sizing.heightByMQ(context, 0.1),
            ),
            AnimatedTextKit(pause: const Duration(seconds: 5), animatedTexts: [
              ColorizeAnimatedText(
                l10n.welcome,
                textStyle: MyTextStyle.bigTitle(context, Colors.black),
                colors: MyColor.colorizeColors,
              ),
            ]),
            SizedBox(
              height: Sizing.heightByMQ(context, 0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
            ElevatedButton(
              onPressed: () {},
              child: Text("sdfadf"),
            )
          ],
        ),
      ),
    );
  }
}
