import 'package:nijimas/application/usecase/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() => false;

  void signInWithGoogle() async {
    final auth = ref.read(authUseCaseProvider);
    state = true;
    final user = await auth.signInWithGoogle();
    state = false;
    if (user == null) {
      print("エラースナックバーを表示予定");
    }
  }

  void signOut() async {
    final auth = ref.read(authUseCaseProvider);
    await auth.signOut();
  }
}
