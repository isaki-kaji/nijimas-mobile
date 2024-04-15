import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n//app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/state/auth_state_provider.dart';
import 'package:nijimas/firebase_options.dart';
import 'package:nijimas/presentation/router/go_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    ref.listen(authStateProvider, (_, __) {
      router.refresh();
    });
    // ref.listen(currentUserStatusProvider, (_, __) {
    //   router.refresh();
    // });
    return MaterialApp.router(
      title: 'Nijimas',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: GoogleFonts.sawarabiMinchoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
