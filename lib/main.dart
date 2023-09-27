import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/router/router.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/cotrollers/auth_controller.dart';
import 'package:nijimas/firebase_options.dart';
import 'package:nijimas/models/user_model.dart';
import 'package:nijimas/widgets/common/error_text.dart';
import 'package:nijimas/widgets/common/loader.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    final authData = ref.read(authStateChangeProvider);
    if (authData is AsyncValue<User> && authData.value != null) {
      getData(ref, authData.value!);
    }
  }

  void getData(WidgetRef ref, User data) async {
    final fetchedUserModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    setState(() {
      userModel = fetchedUserModel;
    });
    ref.read(userProvider.notifier).update(fetchedUserModel);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'nijimas',
            theme: MyColors.myAppTheme,
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    return loggedInRoute;
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
