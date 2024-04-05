import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n//app_localizations.dart';
import 'package:nijimas/core/theme/my_color.dart';
import 'package:nijimas/core/theme/text_style.dart';
import 'package:nijimas/util/sizing.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RegisterUserScreen extends HookConsumerWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final useUsernameController = useTextEditingController();
    return Scaffold(
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
            onPressed: () {
              print(useUsernameController.text);
            },
            child: Text("sdfadf"),
          )
        ],
      ),
      bottomSheet: WaveWidget(
        backgroundColor: Theme.of(context).colorScheme.background,
        config: CustomConfig(
          gradients: MyColor.getWaveColors(),
          durations: [10000, 8000],
          heightPercentages: [0.25, 0.3],
        ),
        waveAmplitude: 0,
        size: Size(
          double.infinity,
          Sizing.heightByMQ(context, 0.4),
        ),
      ),
    );
  }
}
