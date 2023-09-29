import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/router/router.dart';
import 'package:nijimas/core/theme/my_colors.dart';
import 'package:nijimas/controllers/auth_controller.dart';
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

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useUserModel = useState<UserModel?>(null);

    void getData(WidgetRef ref, User data) async {
      final fetchedUserModel = await ref
          .watch(authControllerProvider.notifier)
          .getUserData(data.uid)
          .first;

      useUserModel.value = fetchedUserModel;
      ref.read(userProvider.notifier).update(fetchedUserModel);
    }

    useEffect(() {
      final authData = ref.read(authStateChangeProvider);
      if (authData is AsyncValue<User> && authData.value != null) {
        getData(ref, authData.value!);
      }
      return null;
    }, []);

    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'nijimas',
            theme: MyColors.myAppTheme,
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (useUserModel.value != null) {
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
