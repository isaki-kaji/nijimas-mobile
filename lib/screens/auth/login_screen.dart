import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/widgets/sign_in_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: const Text("skip"))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(Constants.nijimasTitlepath, height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(Constants.nijimasLogoPath,
                  height: MediaQuery.of(context).size.height * 0.45),
            ),
            SignInButton(
                labelText: "Continue with Google",
                logo: Image.asset(
                  Constants.googleLogoPath,
                  width: 35,
                )),
            SignInButton(
                labelText: "Continue with Apple",
                logo: const Icon(
                  Icons.apple,
                  color: Colors.black,
                  size: 35,
                )),
          ],
        ),
      ),
    );
  }
}
